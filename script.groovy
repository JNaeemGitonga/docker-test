#!/usr/bin/env groovy
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

void writeToFile(fileName, data) {
    json_str = JsonOutput.toJson(data)
    File file = new File(fileName)
    file.write(json_str)
    println('LOOK I WROTE THE FILE  ')
}

// for type converting string to bool
boolean asBoolean(param) {
    return param == 'true' ? true : false
}

void bump(fileVersion, fileJson) {
    Boolean release = asBoolean(/*args[0]*/params.release)
    int idx = release == true ? 1 : 2
    int patch = fileVersion[idx].toInteger()
    fileVersion[idx] = patch + 1
    fileJson.serviceVersion = fileVersion.join('.')
    println('LOOK I BUMPED THE VERSION')
    println(fileJson)
}

void bumpVersion() {
    String yorcName = '.yo-rc.json'
    String projectConfigName = 'project-config.json'
    def jsonSlurper = new JsonSlurper()
    def projectConfigJson = jsonSlurper.parse(new File(projectConfigName))
    def yorcJson = jsonSlurper.parse(new File(yorcName))
    String[] yorcVersion = yorcJson.serviceVersion.split('\\.')
    String[] projectConfigVersion = projectConfigJson.serviceVersion.split('\\.')
    bump(yorcVersion, yorcJson)
    bump(projectConfigVersion, projectConfigJson)
    writeToFile(projectConfigName, projectConfigJson)
    writeToFile(yorcName, yorcJson)
}

void commitAndPush() {
    sh '''#!/bin/bash
        git fetch origin
        git stash
        git stash apply
        git commit -am "fix: update version"
        git push origin add-jenkins
    '''
}

// bumpVersion()
return this
