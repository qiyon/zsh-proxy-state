# zsh-proxy-state.plugin.zsh
#
# 该插件提供了一个函数，用于检查代理环境变量是否设置。

# 定义默认配置
: ${ZSH_PROXY_STATE_ICON:="🌍"}
: ${ZSH_PROXY_STATE_COLOR:="magenta"} # 品红色
: ${ZSH_PROXY_STATE_TEXT:="[PX-On]"}

# 定义一个函数来检查代理状态
# 如果设置了 http_proxy, https_proxy, all_proxy (大小写均可)，则返回格式化的指示器
zsh_proxy_state_info() {
  if [[ -n "$http_proxy" || -n "$https_proxy" || -n "$HTTP_PROXY" || -n "$HTTPS_PROXY" || -n "$all_proxy" || -n "$ALL_PROXY" ]]; then
    echo "%F{$ZSH_PROXY_STATE_COLOR}${ZSH_PROXY_STATE_ICON}${ZSH_PROXY_STATE_TEXT}%f"
  fi
}

# 注入函数：尝试将代理状态指示器添加到 PROMPT 变量中的 git_prompt_info 之后
# 用法：在 .zshrc 中 source oh-my-zsh.sh 之后调用 `zsh_proxy_state_inject`
zsh_proxy_state_inject() {
  # 使用 Zsh 的字符串替换功能
  # 将 $(git_prompt_info) 替换为 $(git_prompt_info) $(zsh_proxy_state_info)
  # 注意：这就要求主题必须使用 $(git_prompt_info) 这种标准形式
  if [[ "$PROMPT" == *"\$(git_prompt_info)"* ]]; then
    PROMPT="${PROMPT/\$\(git_prompt_info\)/\$(git_prompt_info) \$(zsh_proxy_state_info)}"
  fi
}
