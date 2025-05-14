# 一、buffer分支和master分支的双线管理
这种情况下，需要合理管理代码合并，以避免冲突和代码丢失。建议采用以下方式进行协作：  

## 1. 分支策略  
- **`master` 分支**：主分支，始终保持稳定，只接受经过测试的代码。  
- **`buffer` 分支**：用于开发人员的独立推进，在功能完成后合并到 `master`。  

## 2. 协作流程  
### (1) `buffer` 分支开发者的操作  
1. **基于最新 `master` 创建 `buffer` 分支**：
   ```bash
   git checkout master
   git pull origin master  # 确保本地 master 最新
   git checkout -b buffer  # 创建 buffer 分支
   ```
2. **在 `buffer` 分支开发**，并定期提交代码：
   ```bash
   git add .
   git commit -m "开发 buffer 分支的功能"
   ```
3. **保持 `buffer` 分支与 `master` 同步**（定期合并 `master`）：
   ```bash
   git checkout master
   git pull origin master   # 获取最新的 master
   git checkout buffer
   git merge master         # 合并最新 master 到 buffer
   ```
   **解决冲突**（如有），然后继续开发。  

4. **开发完成后，提交 `buffer` 并创建合并请求（PR/MR）**：
   ```bash
   git push origin buffer
   ```
   - 让 `master` 负责人审核代码，确定可以合并后执行合并。

### (2) `master` 分支维护者的操作  
1. **定期拉取 `master` 代码**，保持最新：
   ```bash
   git checkout master
   git pull origin master
   ```
2. **合并 `buffer` 分支**：
   ```bash
   git merge buffer
   ```
   **如果有冲突**，解决后提交：
   ```bash
   git add .
   git commit -m "解决合并冲突"
   git push origin master
   ```
3. **合并完成后，可删除 `buffer` 分支**：
   ```bash
   git branch -d buffer
   git push origin --delete buffer
   ```

### (3) `buffer` 分支开发者的普遍操作（上面实为特殊情况）：
1.**下载GitHub的备份**：
   ```bash
   git clone <地址>
   ```
2.**提交至GitHub**：
   ```bash
   git branch -a                  #列出所有本地分支和远程分支
   git checkout buffer         #切换到分支buffer，并更新工作区
   git branch                      #检查上一步是否切换分支成功
   git add .                         #添加当前目录的所有文件到暂存区
   git status                        #检查暂存区的变化
   git commit -m <注释>    #提交暂存区到仓库区
   git push                          #提交到github
   ```

## 3. 注意事项  
- **定期同步 `buffer` 与 `master`**，防止积累过多冲突。  
- **使用 PR/MR 进行代码审核**，确保 `buffer` 代码稳定后再合并。  
- **保持清晰的提交记录**，避免多人修改导致混乱。  
- **避免直接在 `master` 上开发**，始终使用分支进行功能开发。  

这样可以确保 `buffer` 分支和 `master` 分支能够顺利协作，并减少合并时的冲突风险。





# 二、代码上的问题
在编写代码时遇到的问题

## 1.项目设置
- `显示-窗口-拉伸-模式和比例`
- `显示-窗口-大小-置顶`

## 2.大小问题
由于背景大小，我进行了直接放大图像处理。
- 在点击抓取物品时，鼠标上的物品还是保持原来的 `16px` ，两种解决方案， `第一种` 是美术组提供的物品资源需要更大， `第二种` 是点击时出现直接使用或丢弃物品小界面。
- 放大背景后不能依靠锚点移动整体位置，只能在 `Transform-Position` 调整。

## 3.节点问题
- 注意调整节点的顺序，在下面的节点会覆盖在上面的节点。