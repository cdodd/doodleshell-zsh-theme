# Define text colours
default="%b%f"
blue_bold="%B%F{blue}"
green_bold="%B%F{green}"
grey="%F{244}"
red="%F{red}"
yellow="%F{yellow}"
yellow_bold="%B%F{yellow}"

# Define colours for text and icons
icon_colour=${grey}
root_icon_colour=${yellow}
non_zero_return_colour=${red}
aws_profile_color=${yellow_bold}
tf_version_color=${blue_bold}
git_branch_color=${green_bold}

# Define icons
root_icon=""
user_icon=""
computer_icon=""
folder_icon=""
aws_icon=""
terraform_icon=""
git_icon=""
arrow_icon=""

prompt_user() {
  if [[ ${UID} -eq 0 ]]; then
    echo -n "${root_icon_colour}${root_icon}${default} %n "
  else
    echo -n "${icon_colour}${user_icon}${default}  %n "
  fi
}

prompt_host() {
  echo -n "${icon_colour}${computer_icon}${default}  %m "
}

prompt_dir() {
  echo -n "${icon_colour}${folder_icon}${default}  %~ "
}

prompt_aws_profile() {
  if (( ${+AWS_PROFILE} )); then
    echo -n "${icon_colour}${aws_icon}${default}  ${aws_profile_color}${AWS_PROFILE}${default} "
  fi
}

prompt_tf_version() {
  if [[ -f ".terraform-version" ]]; then
    TF_VERSION=$(cat .terraform-version)
    echo -n "${icon_colour}${terraform_icon}${default}  ${tf_version_color}${TF_VERSION}${default} "
  fi
}

prompt_git() {
  # See if we can get a git branch
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if [[ $? -eq 0 ]]; then
    # Output the branch
    GIT_PS="${icon_colour}${git_icon}${default} ${git_branch_color}${GIT_BRANCH}${default}"

    # Get the git status
    GIT_STATUS=$(git status)

    # Check for any unstaged changes
    echo "${GIT_STATUS}" | grep -E "Changes not staged for commit|Changed but not updated" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
      GIT_PS="${GIT_PS}${yellow}*${default}"
    fi

    # Check for any staged changes
    echo "${GIT_STATUS}" | grep "Changes to be committed" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
      GIT_PS="${GIT_PS}${yellow}+${default}"
    fi

    echo -n "${GIT_PS} "
  fi
}

prompt_break() {
  echo ""
}

prompt_arrow() {
  if [ "${RETVAL}" -eq 0 ]; then
    echo "${icon_colour}${arrow_icon}${default}"
  else
    echo "${non_zero_return_colour}${arrow_icon}${default}"
  fi
}

build_prompt() {
  RETVAL=$?
  prompt_break
  prompt_user
  prompt_host
  prompt_dir
  prompt_break
  prompt_aws_profile
  prompt_tf_version
  prompt_git
  prompt_arrow
}

PROMPT='$(build_prompt) '
