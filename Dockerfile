FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    openjdk-8-jre \
    openjdk-8-jdk \
    git \
    gradle \
    wget \
    fonts-liberation \
    libappindicator3-1 \ 
    libxss1 \
    lsb-release \
    xdg-utils

RUN update-java-alternatives --set /usr/lib/jvm/java-1.8.0-openjdk-amd64

ENV ANDROID_SDK_VERSION 4333796
RUN mkdir -p /opt/android && cd /opt/android && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip

RUN mkdir -p /opt/node && cd /opt/node && \
    wget -q https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.gz && \
    tar xf node-v10.13.0-linux-x64.tar.gz && \
    rm node-v10.13.0-linux-x64.tar.gz

RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb

RUN mkdir -p /opt/webdriver && cd /opt/webdriver && \
    wget -q https://chromedriver.storage.googleapis.com/2.44/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    rm chromedriver_linux64.zip && \
    mv chromedriver /usr/bin/chromedriver

ENV PATH=/opt/node/node-v10.13.0-linux-x64/bin:/opt/android/tools/bin:/opt/webdriver:$PATH
ENV ANDROID_HOME=/opt/android/tools
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

RUN yes | sdkmanager "platform-tools" "platforms;android-28" "platforms;android-27" "platforms;android-26" "platforms;android-25" "platforms;android-24" "platforms;android-23" "platforms;android-22" "platforms;android-21" "platforms;android-19"

RUN npm install -g grunt cordova

