#!/usr/bin/env bash

# Run via
#   curl -L https://raw.github.com/hjdivad/home/master/install.sh \
#     > /tmp/install.sh && bash /tmp/install.sh

function fail {
  echo $@
  exit 1;
}

echo "Checking prerequisites."

which make 2>&1 > /dev/null &&\
  echo "make found.  Presumably XCode installed." ||\
  fail 'No make in your $PATH.  Do you have XCode installed?';

which git 2>&1 > /dev/null &&\
  echo "git found." ||\
  fail 'no git found in your $PATH.';

which ruby 2>&1 > /dev/null &&\
  echo "ruby found." ||\
  fail 'no ruby found in your $PATH';


which brew 2>&1 > /dev/null && echo "Homebrew already installed." || {
  echo "Installing Homebrew";
  ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
}

which gcc-4.2 2>&1 > /dev/null && echo "gcc-4.2 installed." || {
  echo "Installing buildtools."
  brew update;
  brew tap homebrew/dupes;
  brew install autoconf automake apple-gcc42
}

ls /usr/bin/gcc-4.2 2>&1 > /dev/null && echo "gcc-4.2 is in /usr/bin" || {
  (cd /usr/bin && sudo ln -s /usr/local/bin/gcc-4.2)
}


which rvm 2>&1 > /dev/null && echo "RVM already installed." || {
  echo "Installing RVM";
  rvm pkg install openssl;
  curl -L https://get.rvm.io | bash -s stable;
}

echo "Setting up rvmrc."
grep -q 'rvm_archflags' $HOME/.rvmrc 2> /dev/null ||
  echo 'rvm_archflags="-arch x86_64"' >> $HOME/.rvmrc
grep -q 'rvm_auto_reload_flag' $HOME/.rvmrc 2> /dev/null ||
  echo 'rvm_auto_reload_flag=2' >> $HOME/.rvmrc
grep -q 'rvm_trust_rvmrcs_flag' $HOME/.rvmrc 2> /dev/null ||
  echo 'rvm_trust_rvmrcs_flag=1' >> $HOME/.rvmrc


source ~/.rvm/scripts/rvm;
rvm list | grep -q ruby-1.9.3 && echo "rvm ruby 1.9.3 already installed." || {
  echo "Setting up default rvm ruby"
  rvm install 1.9.3;
  rvm --default use 1.9.3;
  rvm use 1.9.3@global;
  gem install rake bundler;
}


DownloadsPath=$HOME/Downloads
RepoPath=$DownloadsPath/home

if [ ! -d $RepoPath ]; then
  echo "Downloading home repo."
  cd $DownloadsPath && git clone https://github.com/hjdivad/home.git ||\
    fail "Unable to download home repo."
else
  echo "Updating home repo."
  cd $RepoPath && git fetch origin && git checkout -f origin/master &&\
    git submodule update --init ||\
    fail "Unable to update home repo."
fi


echo "Running chef."
cd $RepoPath
bundle check 2>&1 > /dev/null && [ -d bin ] || bundle install --binstubs
ROLES="workstation" ./bin/soloist && ROLES="home" ./bin/soloist
