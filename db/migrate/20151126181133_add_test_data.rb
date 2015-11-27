# No, don't actually create test data in a migration. I'm doing this
# to keep the bash script simple for this test code.

# Also, if you revert this migration it will destroy all your posts,
# not just the ones it creates.

class AddTestData < ActiveRecord::Migration
  def up
    Post.create! title: "A flock of ducks", body: "Totally.", frivolous: 7
    Post.create! title: "A murder of crows", body: "On Tuesday I saw it.", frivolous: 1
    Post.create! title: "A complexity of programmers", body: "Well, possibly. Or maybe accountants?"
  end

  def down
    Post.delete_all
  end
end
