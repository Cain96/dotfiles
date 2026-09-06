---
name: engineering-principles
description: >-
  設計・実装・検証・委譲を貫く 21 の工学原則のインデックス。
  非自明な変更、アーキテクチャ判断、リファクタ、移行、デバッグ、多段階の作業に着手する前に読み、
  適用する原則は references/ の全文を必ず開く。
  Use before non-trivial code changes, architecture decisions, refactors, migrations, debugging,
  or multi-step work; also for "原則に照らして", "設計方針を決めて", or /engineering-principles.
disable-model-invocation: false
---

# Engineering principles

21 の原則のインデックス。各項は**いつ適用するか**と一行のルールを示す。

## 使い方

**適用する原則は `references/<名前>.md` を全文読む。** インデックスの一行だけで適用したことにしない。葉の本文には、その原則を適用し損ねた兆候（tell）と判定手順が書いてある。そこが本体。

**引用したら、それが変えた具体的な決定を名指しする。** 「laziness-protocol に従い」とだけ書いて、実際にどの選択が変わったかを言えないなら、葉を読んでいない。裏付けのない引用は飾りであって、書かないほうがましになる。

**適用しないと決めた原則も、理由を一行で残す。** 黙って飛ばさない。

---

## 中核

| 原則 | いつ適用するか |
|---|---|
| [laziness-protocol](./references/laziness-protocol.md) | リファクタするとき、diff の大きさを測るとき、抽象・層・シグナルの引き回しを足したくなったとき。削除と、問題を解く最小の変更に寄せる |
| [foundational-thinking](./references/foundational-thinking.md) | ロジックを書く前。中核の型とデータ構造を選ぶとき、足場と機能の順序を決めるとき、並行する主体が何を共有するかを問うとき |
| [redesign-from-first-principles](./references/redesign-from-first-principles.md) | 新しい要件を既存設計に統合するとき。後付けせず、初日からの前提だったかのように再設計する |
| [subtract-before-you-add](./references/subtract-before-you-add.md) | 追加・リファクタ・書き直しの順序を決めるとき。死んだ重りを先に削り、簡素になった土台の上に建てる |
| [minimize-reader-load](./references/minimize-reader-load.md) | 追いにくいコードをレビュー・整形するとき。問いと答えの間の層数と、読者が頭に保持する隠れ状態を数える |
| [outcome-oriented-execution](./references/outcome-oriented-execution.md) | 段階境界が明示された書き直しや移行のとき。目標アーキテクチャに収束させ、使い捨ての互換コードで中間状態を滑らかにしない |
| [experience-first](./references/experience-first.md) | プロダクト・UX・機能スコープのトレードオフが出たとき。実装の都合より使い手の体験を選ぶ |
| [exhaust-the-design-space](./references/exhaust-the-design-space.md) | 前例のない相互作用やアーキテクチャ判断のとき。2〜3 の競合する試作を作って並べてから決める |
| [build-the-lever](./references/build-the-lever.md) | 非自明な作業すべて。手作業でなく、それを行うか証明する道具（codemod、スクリプト、生成器、委譲先が読む skill）を作る。**道具はレビュアーが再実行できる成果物** |

## アーキテクチャ

| 原則 | いつ適用するか |
|---|---|
| [model-the-domain](./references/model-the-domain.md) | 状態を持つロジックを書くとき、分岐が増えるとき、同じ形の前提が複数ファイルに散るとき。散らばった条件分岐でなく構造にドメインを載せる |
| [boundary-discipline](./references/boundary-discipline.md) | バリデーション、エラー処理、フレームワークアダプタを繋ぐとき。境界にガードを集め、内部の型は信じ、業務ロジックは純関数に置く |
| [type-system-discipline](./references/type-system-discipline.md) | 型やシグネチャを設計するとき（言語問わず）。不正な状態を表現不能にし、意味を持つプリミティブに印を付け、外部データは境界で解析する |
| [make-operations-idempotent](./references/make-operations-idempotent.md) | クラッシュや再試行の中で走るコマンド・ライフサイクル・ループを設計するとき。途中経過に関わらず同じ終状態に収束させる |
| [migrate-callers-then-delete-legacy-apis](./references/migrate-callers-then-delete-legacy-apis.md) | 旧呼び出し元が残る状態で新しい内部 API を入れるとき。同じ波で移行しきって旧 API を消す |
| [separate-before-serializing-shared-state](./references/separate-before-serializing-shared-state.md) | 並行する主体が同じファイル・ブランチ・キー・オブジェクトに書きうるとき。まず共有そのものを消す。「ロックが要る」は設計の臭い |

## 検証

| 原則 | いつ適用するか |
|---|---|
| [prove-it-works](./references/prove-it-works.md) | 作業完了後、done と宣言する前。代理指標・自己申告・「コンパイルは通る」ではなく実物で検証する |
| [fix-root-causes](./references/fix-root-causes.md) | デバッグ時。症状を根本原因まで辿ってそこで直す。先に再現し、根に届くまで why を問い、クラッシュを黙らせる nil チェックに抗う |
| [sequence-verifiable-units](./references/sequence-verifiable-units.md) | 多段階の作業（一括置換、移行、同種の編集の連続）と、コミット・PR の積み方。各単位が検査で終わる形に割り、次に進む前に確認し、並びそのものがレビュアーへの論証になるよう順序づける |

## 委譲

| 原則 | いつ適用するか |
|---|---|
| [guard-the-context-window](./references/guard-the-context-window.md) | コンテキストが埋まってきたとき。大量の出力、長いファイル、繰り返しの読み込み、fan-out の計画。かさばるものは subagent に回し、本流には要約だけ残す |
| [never-block-on-the-human](./references/never-block-on-the-human.md) | 可逆な作業で「X してよいですか」と聞きたくなったとき。進めて結果を見せ、事後に軌道修正してもらう。確認は不可逆な操作のために取っておく |

## メタ

| 原則 | いつ適用するか |
|---|---|
| [encode-lessons-in-structure](./references/encode-lessons-in-structure.md) | 同じ指示を 2 度目に書いていると気づいたとき。文章を増やさず、lint・メタデータ・実行時チェック・スクリプトとして埋め込む |
