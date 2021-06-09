# irb
# require '/Users/n.kosuke/workspace/ruby_exam/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）

# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new

# 作成した自動販売機に100円を入れる
# vm.slot_money (100)

# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money

# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

# ステップ2　ジュースの管理
# 格納されているジュースの情報（値段と名前と在庫）を取得する
# vm.return_juice_info

# ステップ3　購入
# vm.buy_juice

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  # 初期状態（値段:120円、名前:”コーラ”、在庫:5本）をインスタンス変数 @juice に代入する
  # 売り上げ金額をインスタンス変数 @sales に代入する
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @juice = [
      { price: 120, name: "cola", stock: 5 }
    ]
    # 最初の売り上げ金額は0円
    @sales = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    # 払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する。
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  # ステップ2　ジュースの管理
  # 格納されているジュースの情報（値段と名前と在庫）を取得する
  def return_juice_info
    @juice.each do |j|
      j.each do |key, value|
        puts "#{key}: #{value}"
      end
    end
  end

  # ステップ3　購入
  def buy_juice
    # 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。
    # 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない。
    if @slot_money < @juice[0][:price] || @juice[0][:stock] == 0
      puts "テスト：何もしない"
    else
      # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
      @juice[0][:stock] -= 1
      # 自動販売機に入っているお金の残金をだす
      @slot_money -= @juice[0][:price]
      # 現在の売上金額を取得できる。
      @sales += @juice[0][:price]
    end
  end
end
