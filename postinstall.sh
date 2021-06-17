# gradle path add#
function gradle_path() { export PATH=$PATH:/opt/gradle/bin }

# sqlite path add
function sqlite_path() { export PATH="/opt/homebrew/opt/sqlite/bin:$PATH" }

# найти все установленные версии java
function get_jdks() { /usr/libexec/java_home -V }

# запустить jenkins
function start_jenkins() { jenkins-lts }

# доустановки java
function postinstall_jdk() {
    export JDK_HOME=/Library/Java/JavaVirtualMachines/liberica-jdk-11-full.jdk/Contents/Home
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/liberica-jdk-11-full.jdk/Contents/Home
}

# CleanMyMac HealthMonitor process disable
function CMMHM_disable() {
    cd "/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac X Menu.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/"
    mv "CleanMyMac X HealthMonitor" "CleanMyMac X HealthMonitor.old"
}

function reset_dock() {
    defaults delete com.apple.dock
    killall Dock
}

function mega_path() { export PATH=/Applications/MEGAcmd.app/Contents/MacOS:$PATH }
