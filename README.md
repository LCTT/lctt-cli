# gn2.sh

Script to help "LCTT" -->  **[TranslateProject](https://github.com/LCTT/TranslateProject)**

![lctt-cli Gif](https://raw.githubusercontent.com/LCTT/lctt-cli/master/images/lctt-cli.gif)

## Platforms

- CentOS/Fedora and derivatives
- Debian/Ubuntu and derivatives
- WindowsXP/7/8/10 for [Git SCM](https://git-for-windows.github.io/)
- Bash on WSL(Windows Subsystem for Linux)

## Recipes
### Installation

```
git clone https://github.com/LCTT/lctt-cli/ /usr/local/lctt-cli
ln -s /usr/local/lctt-cli/gn2.sh /usr/bin/gn2
```
### Solution ( Report By `--check` Option )

```
Q1: Error: OS Language
A1: Try to set environment variable 'LANG=zh_CN.UTF-8'
```
Q2: Error: Configure user.name AND user.email
A2: Please configure user.name AND user.email INTO git repository. See More:[配置用户名和邮箱](https://github.com/LCTT/TranslateProject/wiki/05-Linux%E4%B8%8B%E7%BF%BB%E8%AF%91%E6%93%8D%E4%BD%9C%E6%8C%87%E5%8D%97%EF%BC%88%E5%91%BD%E4%BB%A4%E8%A1%8C%EF%BC%89)
```
Q1: Error: 
```

## License & Authors

**Author:** Linux.Cn Translation Team ([jiwenkangatech@foxmail.com](mailto:jiwenkangatech@foxmail.com))

**Copyright:** 2016-2017,  Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
