#!/usr/bin/env bash

source ./cshello/setup.bash

md_basename=README



cat << EOF > $md_basename.md


# cshello  
## 该仓库是做什么的？  
用于记录，管理，分享计算机相关方向的知识和运用  

## 该仓库侧重点有哪些？  

1. 与计算机相关，像 计算机视觉，机器视觉，深度学习，高性能计算等领域。
2. 重运用，表达精简，多用图表数据，重视过程。



## 该仓库文档结构
- \`Basics\`, \`Extensions\`, \`Associations\`, \`Projects\`, \`Others\`是根目录下的文件夹  
- \`Basics\` 记录领域的基础知识
- \`Extensions\` 记录对\`Basics\`知识的扩展和灵活运用
- \`Associations\` 记录对知识的综合运用，像源码分析，领域项目等
- \`Projects\` 记录领域内的经典项目
- \`Others\` 记录常用的文本或链接，还有没有知识归类的部分

### EncyclopediaKnowledge  
记录维基百科，百度百科等百科知识，主要从这几个方面讲起
1. 它是什么
2. 它可以解决什么问题
3. 在生活中怎么运用，有什么特殊的案例


## Tree
---

$(gentitles) 

---

EOF





