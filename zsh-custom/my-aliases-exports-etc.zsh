# --
# My custom aliases, path changes, and evals.
# --
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
alias ll="ls -alh"
eval "$(ssh-agent -s)"
