# Oracle-SQL-portfolio
-OracleDatabaseを利用したSQL学習成果物です

## 概要

- 現職で在庫管理業務を担当していたので想像のつきやすい在庫管理システムを想定したデータベース設計を行いました。
Oracle Datebaseを利用し仕入先管理、商品管理、発注管理、在庫履歴管理を行うためのテーブル設計を実施しています。

## 使用環境

- Oracle Datebase XE
- Oracle SQL Developer
- Github

## テーブル構成

- suppliers(仕入先マスタ)
- 仕入先情報を管理
- products(商品マスタ)
- 商品情報及び現在庫を管理
- purchase_orders(発注ヘッダ)
- 発注情報を管理
- purchase_order_details(発注明細)
- 発注明細を管理
- inventory_history(在庫増減履歴)
- 商品の入出庫履歴を管理

## 実装内容

- テーブル設計
- シーケンスによる主キー採番
- 主キー・外部キー制約
- サンプルデータ投入
- JOINやGROUP BY等を利用した集計処理、データ取得

## 工夫した点

- 現職で在庫管理及び発注業務を担当していた経験を元に、実際の業務で利用されることを意識してテーブル設計を行いました。
- 商品の入出庫履歴を管理できるようinventory_historyテーブルを作成し、現在庫を管理するproductsテーブルと分離しました。
- 現在庫だけでなく、過去の入出庫履歴を管理できる構成とし、入出庫時にはproductsテーブルのcurrent_stock(現在庫)及びlast_updated(在庫最終更新日)を更新することを想定しています。

## 学習内容

- Oracle SQL
- Oracle DBA Silver

## 今後の改善点

- トリガーによる在庫自動更新
- ビューを利用したレポート機能



