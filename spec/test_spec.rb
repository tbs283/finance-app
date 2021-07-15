RSpec.describe Blog, "モデルに関するテスト", type: :model do
6	  describe '実際に保存してみる' do
7	    it "有効な投稿内容の場合は保存されるか" do
8	      expect(FactoryBot.build(:blog)).to be_valid
9	    end
10	  end
11	  context "空白のバリデーションチェック" do
12	    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
13	      book = Book.new(title: '', content:'hoge')
14	      expect(blog).to be_invalid
15	      expect(blog.errors[:title]).to include("can't be blank")
16	    end
17	    it "contentが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
18	      book = Book.new(title: 'hoge', content:'')
19	      expect(blog).to be_invalid
20	      expect(blog.errors[:content]).to include("can't be blank")
21	    end
22	  end
23	end

