# 実データ収集に関するドキュメント

__[everyday-todo.md](./everyday-todo.md)が完了してから本内容に従ってデータを収集__

## 前提条件

[everyday-todo.md](./everyday-todo.md)で`uv run lefobot-find-cameras`した後、setup.shに確認したカメラIDを設定しているが、またまれにcameraのindexが変わることがある（コマンドがエラーになる）ので、その際は`uv run lerobot-find-cameras`で改めてcameraのインデックスを確認。その後`setup.sh`に値を設定して、再度`source setup.sh`を実行。そして、`echo $FRONT_CAM_ID`で設定したカメラIDが表示されることを確認

## テレオペ確認

```shell
uv run lerobot-teleoperate \
  --robot.type=ugo_pro \
  --robot.id=my_ugo_pro \
  --robot.cameras="{ front: {type: opencv, index_or_path: $FRONT_CAM_ID, width: 640, height: 480, fps: 30}, left: {type: opencv, index_or_path: $LEFT_CAM_ID, width: 640, height: 480, fps: 30}, right: {type: opencv, index_or_path: $RIGHT_CAM_ID, width: 640, height: 480, fps: 30}}" \
  --teleop.type=ugo_bilcon \
  --teleop.id=my_ugo_bilcon \
  --display_data=true
```

## データ収集

```shell
uv run lerobot-record \
  --robot.type=ugo_pro \
  --robot.id=my_ugo_pro \
  --robot.cameras="{ front: {type: opencv, index_or_path: $FRONT_CAM_ID, width: 640, height: 480, fps: 30}, left: {type: opencv, index_or_path: $LEFT_CAM_ID, width: 640, height: 480, fps: 30}, right: {type: opencv, index_or_path: $RIGHT_CAM_ID, width: 640, height: 480, fps: 30}}" \
  --teleop.type=ugo_bilcon \
  --teleop.id=my_ugo_bilcon \
  --display_data=true \
  --dataset.fps=30 \
  --dataset.reset_time_s="$REST_TIME" \
  --dataset.episode_time_s="$EPISODE_TIME" \
  --dataset.push_to_hub=false \
  --dataset.repo_id="$REPO_ID" \
  --dataset.single_task="$TASK_NAME" \
  --dataset.num_episodes=1 \
  --resume=true
```

コマンド実行後、以下の1まで進め初期姿勢をとり、その後recoding episodeという音声が聞こえたら、2のタスクの内容を実行する。そしてタスクが完了したら、3-4-5の順に進める。

1. 以下の内容に従って初期姿勢をとる。[./init-pose.md](./init-pose.md)を参照。
2. 以下の内容に従ってタスクを実行する
3. 以下の内容に従って完了姿勢をとる。[./final-pose.md](./final-pose.md)を参照。
4. PCの右矢印を押下し、レコーディングを止める。（時間切れの場合は押下する前にレコーディングが終了する）
5. データ収集が成功したかどうか確認があるので、y（成功）/n（失敗）/u（不明）いずれかを押下して、記録を完了させる

<!-- 6. グリッパー閉じる
7. 腕の高さをボックスより少し高い位置、奥行きはテーブルの手前、横方向を2つの郵便受けの間にする。（レクシャーします。）
8. 腕を操作して奥行きを郵便物が取れる位置まで伸ばす。
9. グリッパーを郵便物を余裕で掴める広さまで解放
10. 腕を郵便物が掴める高さまで移動（下げる）
11. 郵便物をグリッパーで握る
12. 腕を郵便受けの高さよりも高い位置に調整（上げる）
13. 腕を横移動させて、指定の郵便受けの位置に合わせる。（横移動）
14. 印の真ん中に郵便物が来るように奥行きを合わせる
15. 郵便物が郵便受けの底あたりにつく程度まで腕を下げる（くっつかない程度）
16. グリッパーを解放して、郵便物を離す
17. 腕を郵便受けよりも少し高い位置に持ち上げる。
18. 腕を引いて、肘がセットポジションの位置に戻す
19. 手首を上げて、カメラでテーブルの上が見えるようにする
20. グリッパーを握る
21. PCの右矢印を押下してレコーディングを止める（時間切れの場合は、レコーディングを止めることはできない）
22. 最後にデータ収集が成功したかどうか確認があるので、y（成功）/n（失敗）/u（不明）いずれかを押下して、記録を完了させる -->

失敗の条件

- recoding 時間終了までに作業を完了できなかった（16まで完了できていない）
- 腕を机にぶつけてしまった
- 腕を郵便受けにぶつけてしまった
- 郵便物を移動させたときに郵便受けに郵便物をぶつけてしまった。

成功の条件

- 時間内に作業を完了させた（16まで完了している）
- 一度掴み取ろうとして、掴み損ねたが、リトライして成功している

## 注意事項

- 丁寧な作業をお願いします。
- ロボットはオペレーターの操作を模倣して動けるようになるため、作業スピードが一定ではない（特定のエピソードでは極端に早く、別のエピソードでは極端に遅いなど）場合、学習しずらいデータになります。
