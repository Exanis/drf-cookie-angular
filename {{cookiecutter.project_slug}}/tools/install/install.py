import os, time
import requests
from github import Github
from travispy import TravisPy, travispy


# Environment variables
PROJECT_NAME="{{cookiecutter.project_name}}"
PROJECT_DESCRIPTION="{{cookiecutter.description}}"
REPOSITORY_NAME="{{cookiecutter.project_slug}}"
OWNER_NAME="{{cookiecutter.github_owner}}"
GITHUB_TYPE="{{cookiecutter.github_user_type}}"

{% if cookiecutter.repository_type == "private" %}
PROJECT_PRIVATE=True
{% else %}
PROJECT_PRIVATE=False
{% endif %}

GITHUB_PASSWORD=os.environ["GITHUB_PASSWORD"]

print("Logging into Github")
github = Github(OWNER_NAME, GITHUB_PASSWORD)

print("Creating github repository")
{% if cookiecutter.github_user_type == 'user' %}
repository = github.get_user().create_repo(
    name=PROJECT_NAME,
    description=PROJECT_DESCRIPTION,
    private=PROJECT_PRIVATE
)
{% else %}
repository = github.get_organization(GITHUB_TYPE).create_repo(
    name=PROJECT_NAME,
    description=PROJECT_DESCRIPTION,
    private=PROJECT_PRIVATE
)
{% endif %}

{% if cookiecutter.use_travis == 'y' %}
print("Creating github auth token")
auth = github.get_user().create_authorization(
    scopes=[
            "read:org",
            "user:email",
            "repo_deployment",
            "repo:status",
            "public_repo",
{% if cookiecutter.repository_type == 'private' %}
            "repo",
{% endif %}
            "write:repo_hook"
        ],
    note="temporary token to auth against travis"
)

print("Logging into Travis")
travis = TravisPy.github_auth(
    auth.token,
{% if cookiecutter.repository_type == 'private' %}
    travispy.PRIVATE
{% else %}
    travispy.PUBLIC
{% endif %}
)

print("Asking for sync between travis and github")
initial_sync = travis.user().synced_at
travis.user().sync()

print("Waiting for sync to complete")
complete = False
while not complete:
    time.sleep(10)
    user = travis.user()
    complete = user.synced_at != initial_sync

print("Fetching repository ID from Travis")
repo = travis.repo(repository.full_name)

print("Adding hook to the repository")
repo.enable()
{% endif %}

# Todo: Add codacy here
{% if cookiecutter.use_codacy == 'y' %}
print("Warning: right now, codacy api's documentation is down and support have no ETA for it to be back.")
print("Please manually add your project to codacy.")
{% endif %}

{% if cookiecutter.use_travis == 'y' or cookiecutter.use_codacy == 'y' %}
auth.delete()
{% endif %}

print("Enabling git here")
os.chdir('/usr/src/content')
os.system('mv tools/install/ssh /root/.ssh') # Copy key from original location because WSL mess with permissions if not
os.system('chmod 0700 /root/.ssh/*') # Fix permissions on copied SSH key - this is usefull on WSL
os.system('git config --global user.email "{{cookiecutter.email}}"')
os.system('git config --global user.name "{{cookiecutter.author_name}}"')
os.system('git init .')
os.system('git add --all')
os.system('git reset tools/install')
os.system('git commit -m "Initial import of {{cookiecutter.project_name}}"')
os.system('git remote add origin %s' % repository.ssh_url)
os.system('git push -u origin master')

print("Activating branch protection")
# Note : Need to use direct github call here since github client does not include branch protection
# TODO Remove this from here as soon as we can
{% if cookiecutter.github_user_type == 'user' %}
print("Error: Right now, Github API does not work for branch protection on user level. Please protect your branch by yourself.")
print("You can do so by going to github and manually enabling branch protection in your project's settings")
{% else %}
r = requests.put(
    'https://api.github.com/repos/%s/branches/master/protection' % repository.full_name,
    json={
        {% if cookiecutter.use_travis == 'y' or cookiecutter.use_codacy == 'y' %}
        'required_status_checks': {
            'strict': True,
            'contexts': [
                {% if cookiecutter.use_travis == 'y' %}
                'continuous-integration/travis-ci',
                {% endif %}
                {% if cookiecutter.use_codacy == 'y' %}
                'codacy/pr',
                {% endif %}
            ]
        },
        {% endif %}
        'required_pull_request_reviews': {
            'dismiss_stale_reviews': True
        },
        "enforce_admins": True,
        "restrictions": {
            "users": [],
            "teams": []
        }
    },
    auth=(OWNER_NAME, GITHUB_PASSWORD)
)
{% endif %}

print("Github project created and configured.")
