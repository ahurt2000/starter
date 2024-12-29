# Initializer PHP 8.4 and Symfony project with docker

**Intention**: Make it easier to create PHP/Symfony projects in docker containers.

*Requirements*: You have git, docker and docker-compose installed on your system.

**Summary**:

To start a new PHP/Symfony project, follow these steps:

- Clone the repository
- Add the project to your /etc/hosts
- Run the script aliases.zsh (or aliases.sh for bash)
- Start the docker containers
- Install Symfony
- Start coding your project

### Start by cloning the project

```
git clone https://github.com/ahurt2000/phpWebAppStarter.git new_project_folder
cd new_project_folder
```

**Replace COMPOSE_PROJECT_NAME with the name you want to give to your project.**

### Add the project to hosts

It is important to add an entry in your system's hosts file. To find its location, use this link [https://en.wikipedia.org/wiki/Hosts_(file)](https://en.wikipedia.org/wiki/Hosts_(file))

```
127.0.0.1 COMPOSE_PROJECT_NAME.local
```

### Creating the aliases

It is necessary to properly manage the containers, as the docker-compose configuration is distributed across several files.

Run the command that creates the aliases, the first argument is the project name.

For zsh with oh-my-zsh

```
./aliases.zsh COMPOSE_PROJECT_NAME _inhost
source ~/.zshrc
```

For bash
```
./aliases.sh COMPOSE_PROJECT_NAME _inhost
source ~/.bashrc
```

*inhost*: This is an optional argument. By default, MySQL uses the container to store the database, with "_inhost" it is stored on your host in the docker/db/ path.

**Important**: These aliases only work if they are in the project directory.

You can check the aliases by running:

```
alias | grep COMPOSE_PROJECT_NAME
```

### Start the docker containers

```
COMPOSE_PROJECT_NAME-up
```

Example: if your project is named "demo" run: demo-up

### Installing Symfony with composer

```
COMPOSE_PROJECT_NAME-composer create-project symfony/skeleton:"7.2.x-dev" html
```

Go to: https://COMPOSE_PROJECT_NAME.local

### Recommended actions

Initialize git in your project folder html/COMPOSE_PROJECT_NAME

```
cd html/COMPOSE_PROJECT_NAME
git init
```

Also, Docker-compose templates are included for:

- Redis
- Sqlite3

But to use them, you must edit the aliases.
