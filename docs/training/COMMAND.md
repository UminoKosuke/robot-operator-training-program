# オペレータトレーニング時に使用するコマンド一覧

## 環境のセットアップ

プロジェクトのルートディレクトリで以下を実行する。

```shell
source setup.sh
```

## 使用するカメラの確認

```shell
uv run lerobot-find-cameras
```

## テレオペレーションの確認

```shell
uv run lerobot-teleoperate \
  --robot.type=ugo_pro \
  --robot.id=my_ugo_pro \
  # Change the each index_or_path
  --robot.cameras="{ front: {type: opencv, index_or_path: 6, width: 640, height: 480, fps: 30}, left: {type: opencv, index_or_path: 2, width: 640, height: 480, fps: 30}, right: {type: opencv, index_or_path: 10, width: 640, height: 480, fps: 30}}" \
  --teleop.type=ugo_bilcon \
  --teleop.id=my_ugo_bilcon \
  --display_data=true
```

### データ収集

```shell
uv run lerobot-record \
  --robot.type=ugo_pro \
  --robot.id=my_ugo_pro \
  # Change the each index_or_path
  --robot.cameras="{ front: {type: opencv, index_or_path: 6, width: 640, height: 480, fps: 30}, left: {type: opencv, index_or_path: 2, width: 640, height: 480, fps: 30}, right: {type: opencv, index_or_path: 10, width: 640, height: 480, fps: 30}}" \
  --teleop.type=ugo_bilcon \
  --teleop.id=my_ugo_bilcon \
  --dataset.fps=30 \
  --dataset.push_to_hub=false \
  --dataset.repo_id="$REPO_ID" \
  --dataset.single_task="$TASK_NAME" \
  --dataset.root="$REPO_ROOT" \
  --dataset.num_episodes=1 \
  --dataset.reset_time_s=10 \
  # Set the time
  --dataset.episode_time_s=60 \
  --display_data=true \
  --resume=true
```

### データセットの可視化

```shell
uv run lerobot-dataset-viz \
  --repo-id="$REPO_ID" \
  --episode-index=0  # Set the episode you want to visualize.
```

### 収集データのリプレイ

```shell
uv run lerobot-replay \
  --robot.type=ugo_pro \
  --robot.id=my_ugo_pro \
  --dataset.repo_id="$REPO_ID" \
  --dataset.episode=1 # Set the episode you want to replay.
```
