# zsh-proxy-state

一个轻量级的 Oh My Zsh 插件，用于检测并显示当前 Shell 环境的代理状态。

当检测到 `http_proxy`、`https_proxy` 或 `all_proxy` 等环境变量被设置时，它会在你的终端提示符中显示 `PX-On`，让你对网络环境一目了然。

## 安装

1. 将本插件克隆到你的 Oh My Zsh 自定义插件目录：

   ```bash
   git clone https://github.com/qiyon/zsh-proxy-state.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-proxy-state
   ```

2. 编辑 `~/.zshrc` 文件，将 `zsh-proxy-state` 添加到插件列表中：

   ```zsh
   plugins=(... zsh-proxy-state)
   ```

3. 重新加载配置：

   ```bash
   source ~/.zshrc
   ```

## 使用方法

本插件提供了两种方式将代理状态集成到你的提示符（Prompt）中。

### 方法一：自动注入（推荐）

该插件提供了一个便捷的注入函数，可以将代理状态指示器自动添加到 `PROMPT` 变量中 `git_prompt_info` 的后面。

在你的 `~/.zshrc` 文件末尾（**必须在** `source $ZSH/oh-my-zsh.sh` 之后）添加以下代码：

```zsh
# 自动将代理状态显示注入到 Git 信息之后
zsh_proxy_state_inject
```

*注意：此方法依赖于你的主题使用了标准的 `$(git_prompt_info)` 函数。如果你的主题没有使用它，请使用方法二。*

### 方法二：手动配置

你可以手动将 `$(zsh_proxy_state_indicator)` 添加到你的 `PROMPT` 或 `RPROMPT` 变量中。

**示例 1：显示在右侧提示符（推荐）**

在 `~/.zshrc` 末尾添加：

```zsh
RPROMPT='$(zsh_proxy_state_indicator)'
```

**示例 2：自定义 PROMPT**

```zsh
PROMPT='... $(git_prompt_info) $(zsh_proxy_state_indicator) ...'
```

## 配置

你可以通过在 `~/.zshrc` 中（在插件加载之前）设置以下变量来自定义显示效果：

| 变量 | 说明 | 默认值 |
| :--- | :--- | :--- |
| `ZSH_PROXY_STATE_ICON` | 显示的图标/前缀 | `🌍` |
| `ZSH_PROXY_STATE_COLOR` | 显示的颜色 (Zsh 颜色代码/单词) | `magenta` (品红色) |
| `ZSH_PROXY_STATE_TEXT` | 显示的文字内容 | `PX-On` |

**示例：**

```zsh
ZSH_PROXY_STATE_ICON="🚀"
ZSH_PROXY_STATE_COLOR="blue"
ZSH_PROXY_STATE_TEXT="Proxy"
```

## 功能逻辑

插件会检查以下环境变量（不区分大小写）：
- `http_proxy`
- `https_proxy`
- `all_proxy`

只要其中任意一个非空，函数 `zsh_proxy_state_indicator` 就会输出 `PX-On`。
