ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Default values for the user and group
ARG USER_ID
ARG USER_NAME=user
ARG GROUP_ID
ARG GROUP_NAME=user

# Add new user
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} &&\
    useradd -l -u ${USER_ID} -g ${GROUP_NAME} ${USER_NAME} &&\
    install -d -m 0755 -o ${USER_NAME} -g ${GROUP_NAME} /home/${USER_NAME}

# Normally you woldn't add a docker user to the sudo group since a docker should be 
# a complete environment. Adding anything in a runtime (apt get) is not a good idea for a production containers. 
# Here hovewere the contaier is not ment to be used in production but is rather an example and/or a handfull tool to use when needed. 
# For this reason adding user to the sudo group can be handfull.
RUN apt-get update && apt-get install -y apt-utils sudo
RUN echo ${USER_NAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers 

# Change user
USER ${USER_NAME} 
WORKDIR /home/${USER_NAME}