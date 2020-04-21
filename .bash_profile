export BASH_SILENCE_DEPRECATION_WARNING=1

# Because macOS sources bash_profile
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
