FROM openjdk:8-jdk
LABEL authors="Bruno Scrok Brunoro"
LABEL email="bruno.sbrunoro@gmail.com"

ENV ANDROID_HOME=/opt/android-sdk

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/oracle-jdk8-installer \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

RUN wget -O /tmp/android-sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
  && unzip /tmp/android-sdk-tools.zip -d /opt/android-sdk/ 

RUN mkdir /opt/android-sdk/licenses \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > /opt/android-sdk/licenses/android-sdk-license \
  && echo "d56f5187479451eabf01fb78af6dfcb131a6481e" >> /opt/android-sdk/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd" >> /opt/android-sdk/licenses/android-sdk-preview-license 

RUN /opt/android-sdk/tools/bin/sdkmanager --update

RUN /opt/android-sdk/tools/bin/sdkmanager "platform-tools" 
RUN /opt/android-sdk/tools/bin/sdkmanager "build-tools;19.1.0" "build-tools;20.0.0" "build-tools;21.1.2" "build-tools;22.0.1" "build-tools;23.0.3" "build-tools;24.0.3" "build-tools;25.0.2" "build-tools;26.0.2" "build-tools;27.0.3" "build-tools;28.0.0"
RUN /opt/android-sdk/tools/bin/sdkmanager "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27" "platforms;android-28" 
RUN /opt/android-sdk/tools/bin/sdkmanager "extras;google;google_play_services" "extras;google;m2repository" "extras;android;m2repository" 

RUN wget -O /tmp/gradle-3.4.1-bin.zip https://services.gradle.org/distributions/gradle-3.4.1-bin.zip \
 && mkdir /opt/gradle \ 
 && unzip /tmp/gradle-3.4.1-bin.zip -d /opt/gradle 

RUN export ANDROID_HOME=/opt/android-sdk/ \
 && export PATH=$PATH:/opt/android-sdk/platform-tools/ \
 && export PATH=$PATH:/opt/gradle/gradle-3.4.1/bin