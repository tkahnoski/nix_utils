
#Shell Options
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.hist
setopt appendhistory
setopt incappendhistory
setopt sharehistory
setopt extendedhistory
setopt histverify

setopt correct

PS1='%n@%m:%(4~|%-1~/../%2~|%3~)%# '
RPS1="%(?..(%B%?%)) %D{%L:%M}"

#env
export PROJECTS_HOME=/Users/tkahnoski/projects
#shell utils

alias ls='ls -G'
alias ghist="history | grep $@"
alias get_jars="find $PWD -name \"*.jar\" | tr '\012' ':'"
alias get_cljs="find $PWD -name \"*.clj\" | tr '\012' ':'"
#Clojure 
export CLOJURE_PATH=$PROJECTS_HOME/clojure/clojure.jar:$PROJECTS_HOME/clojure-contrib/clojure-contrib.jar

alias reset_clj="export CLOJURE_PATH=$CLOJURE_PATH"
alias clojure="java -cp $CLOJURE_PATH clojure.lang.Repl $@"
alias clj="java -cp $CLOJURE_PATH clojure.lang.Repl $@"
alias clj_main="java -cp $CLOJURE_PATH clojure.main $@"
