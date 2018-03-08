# --
# My custom aliases, path changes, and evals.
# --
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"
export PATH="${HOME}/kotlin-native-macos-0.5/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
export PATH=/usr/local/anaconda3/bin:"${PATH}"
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_SDK="${ANDROID_SDK_ROOT}"
export ANDROID_HOME="${ANDROID_SDK_ROOT}"
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
alias aws-paul="aws --profile paulbaker"
alias aws-dev="aws --profile wgu-dev"
alias aws-sbx="aws --profile sbx"
alias ll="ls -alh"
eval "$(ssh-agent -s)" &>/dev/null
# RVM
source /Users/paul.baker/.rvm/scripts/rvm
