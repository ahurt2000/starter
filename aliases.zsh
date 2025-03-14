#!/usr/bin/env zsh
# creating alias in  zsh (oh-my-zsh) for the project

# put messages in colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

if [ "$1" = "-h" ]; then
    echo -e "${RED}Creating alias for the project${NC}"
    echo -e "${RED}Usage:${CYAN} $0 <project_name> <inhost>"
    echo -e "${RED}project_name:${CYAN} the name of the project"
    echo -e "${RED}inhost: (optional)${CYAN} if the mysql is in the host machine, provide '_inhost' as the second argument${NC}"
    exit 0
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${RED}Oh My Zsh is not installed. Please install it first or use bash.${NC}"
    exit 1
fi

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Please provide the project name${NC}"
    exit 1
fi

#replace in .env file the string PROYECTNAME with the value of $PROJECT_NAME 
sed -i '' "s/PROJECTNAME/"$PROJECT_NAME"/g" .env

INHOST=${2-""}

if [ "$INHOST" != "_inhost" ]; then
    echo "${CYAN}MySQL is not supposed to be '_inhost', so the MySQL database files are in the container. Please provide the second argument as '_inhost' if you want in the inhost.${NC}"
else
    if [ -d "docker/db/mysql" ]; then
        echo "${RED}The folder docker/db/mysql does not exist. Please remove it.${NC}"
        exit 1
    fi
    mkdir docker/db/mysql
    echo "${CYAN}MySQL is now '_inhost', so its files are stored in your PC's database files in the docker/db/mysql folder.${NC}"
fi

PROJECT_DIR=$(pwd)

# create project folder
mkdir -p "$PROJECT_DIR/$PROJECT_NAME"

cd ~/.oh-my-zsh/custom
touch $PROJECT_NAME'_alias.zsh'd
echo "alias "$PROJECT_NAME"-up='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml up -d'" >>$PROJECT_NAME'_alias.zsh'
echo "alias "$PROJECT_NAME"-down='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml down'" >>$PROJECT_NAME'_alias.zsh'
echo "alias "$PROJECT_NAME"-php='docker exec -it "$PROJECT_NAME"-php php'" >>$PROJECT_NAME'_alias.zsh'
echo "alias "$PROJECT_NAME"-composer='docker exec -it "$PROJECT_NAME"-php composer'" >>$PROJECT_NAME'_alias.zsh'
echo "alias "$PROJECT_NAME"-bash='docker exec -it "$PROJECT_NAME"-php bash'" >>$PROJECT_NAME'_alias.zsh'

echo 
echo -e "${GREEN}Now execute: source ~/.zshrc${NC}"
