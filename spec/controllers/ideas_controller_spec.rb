require 'rails_helper'

describe '投稿のテスト' do
  let!(:idea) { create(:idea, title:'hoge',body:'body') }
  describe 'トップ画面(top_path)のテスト' do
    before do
      visit top_path
    end
    context '表示の確認' do
      it 'top_pathが"/top"であるか' do
        expect(current_path).to eq('/top')
      end
    end
  end

  describe "投稿画面(new_idea_path)のテスト" do
    before do
      visit new_idea_path
    end
    context '表示の確認' do
      it 'new_idea_pathが"/ideas/new"であるか' do
        expect(current_path).to eq('/ideas/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'idea[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'idea[body]', with: Faker::Lorem.characters(number:30)
        click_button '投稿'
        expect(page).to have_current_path idea_path(Idea.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit ideas_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content idea.title
        expect(page).to have_link idea.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit idea_path(idea)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/ideas/' + idea.id.to_s + '/edit')
      end
    end
    context 'idea削除のテスト' do
      it 'ideaの削除' do
        expect{ idea.destroy }.to change{ Idea.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_idea_path(idea)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'idea[title]', with: idea.title
        expect(page).to have_field 'idea[body]', with: idea.body
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'idea[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'idea[body]', with: Faker::Lorem.characters(number:30)
        click_button '保存'
        expect(page).to have_current_path idea_path(idea)
      end
    end
  end
end