#!/usr/bin/env bash
# creating alias in bash for the project

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

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Please provide the project name${NC}"
    exit 1
fi

#replace in .env file the string PROYECTNAME with the value of $PROJECT_NAME 
sed -i "s/PROJECTNAME/"$PROJECT_NAME"/g" .env

INHOST=${2-""}
# check if the INHOST is not empty or not is equal to 'inhost'
if [ "$INHOST" != "_inhost" ]; then
    echo -e "${CYAN}MySQL is assumed not inhost. Please provide the second argument as '_inhost' if you want in the inhost${NC}"
fi

# Ensure the aliases are added to .bashrc
BASHRC_FILE=~/.bashrc

# Create the alias file in the project directory
PROJECT_DIR=$(pwd)
ALIAS_FILE="$PROJECT_DIR/$PROJECT_NAME'_alias.sh'"

# Check if the alias file is already sourced in .bashrc
if ! grep -q "$ALIAS_FILE" "$BASHRC_FILE"; then
    echo "source $ALIAS_FILE" >> "$BASHRC_FILE"
fi

touch "$ALIAS_FILE"
echo "alias "$PROJECT_NAME"-up='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml up -d'" >>"$ALIAS_FILE"
echo "alias "$PROJECT_NAME"-down='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml down'" >>"$ALIAS_FILE"
# echo "alias "$PROJECT_NAME"-php='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml run "$PROJECT_NAME"-php '" >>"$ALIAS_FILE"
# echo "alias "$PROJECT_NAME"-composer='docker-compose -f docker-compose.yml -f templates/docker-compose_apache.yml -f templates/docker-compose_mysql"$INHOST".yml run "$PROJECT_NAME"-php composer'" >>"$ALIAS_FILE"
echo "alias "$PROJECT_NAME"-php='docker exec -it "$PROJECT_NAME"-php php'" >>$ALIAS_FILE
echo "alias "$PROJECT_NAME"-composer='docker exec -it "$PROJECT_NAME"-php composer'" >>$ALIAS_FILE


echo -e "${GREEN}Now execute: source ~/.bashrc${NC}"
