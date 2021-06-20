# add MEGAcmd, sqlite, gradle, jdk, groovy to PATH
# https://wpbeaches.com/how-to-add-to-the-shell-path-in-macos-using-terminal/
function add_exec_to_path() {
    cd ~/
    echo "
        export PATH=$PATH:/Applications/MEGAcmd.app/Contents/MacOS:/opt/homebrew/opt/sqlite/bin:/opt/gradle/bin:/opt/homebrew/opt/inetutils/libexec/gnubin
        export JDK_HOME=/Library/Java/JavaVirtualMachines/liberica-jdk-11-full.jdk/Contents/Home
        export JAVA_HOME=/Library/Java/JavaVirtualMachines/liberica-jdk-11-full.jdk/Contents/Home
        export GROOVY_HOME=/opt/homebrew/opt/groovy/libexec
    " > .zshrc
    source .zshrc
    #optional GROOVY_HOME is '/opt/homebrew/Cellar/groovy/3.0.8/libexec'
}

# find all installed jdks
function get_jdks() { /usr/libexec/java_home -V }

# start jenkins
function start_jenkins() { jenkins-lts }

# disable CleanMyMac HealthMonitor process
function CMMHM_disable() {
    cd "/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac X Menu.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/"
    mv "CleanMyMac X HealthMonitor" "CleanMyMac X HealthMonitor.old"
}

# reset default dock size
function reset_dock_size() {
    defaults write com.apple.dock tilesize 64
    killall Dock
}

function clear_trash() { rm -rf /opt/groovy/doc }

# save ssh connections 
# https://superuser.com/questions/76193/how-to-create-an-ssh-connection-terminal-shortcut-on-mac-os-x
function save_ssh_connection() {
    cd ~/.ssh
    if [[ $# -lt 4 ]]; then
        echo "Illegal number of parameters"
        exit
    fi
    echo "
        Host $2
            HostName $3
            User $4
    " >> config
    if [[ $# -eq 5 ]]; then
        echo "
            Port $5
        " >> config
    fi
}

MODES=("--envs" "--dock" "--ssh" "--cmmhm" "--all")
case ${1} in
    ${modes[0]})
        add_exec_to_path
    ;;
    ${modes[1]})
        reset_dock_size
    ;;
    ${modes[2]})
        save_ssh_connection
    ;;
    ${modes[3]})
        CMMHM_disable
    ;;
    ${modes[4]})
        add_exec_to_path
        reset_dock_size
        CMMHM_disable
        save_ssh_connection
        brew install inetutils
    ;;
    *)
        echo "unknown mode"
        echo "modes:"
        for m in ${MODES[@]}; do
            echo $m
        do
    ;;
esac
