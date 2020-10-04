# Getting started

First thing that I did was to go to the Jenkins [website](https://www.jenkins.io/doc/book/installing/#setup-wizard).

I followed the instructions until I got to step 4. I use `docker-compose` so I wanted to be able to start these containers using that. So I went to a web app that will convert docker shell commands to a `docker-compose.yml` format. It's called [Composerize](https://www.composerize.com/). 

I then started the containers but nothing happened when I visited `localhost:8080` so I read further.

I then ran across this command `java -jar jenkins.war`. I didn't follow the instructions well because if I had I would have known that where ever I run this command I would need to have the `jenkins.war` file in that directory (or I would need to write a shell script alias to cd to the directory where it's at and then run that command).

when you do run the `java` command look at the log in the same window for the admin password. this will only be needed on the inital setup