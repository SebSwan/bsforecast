# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_105829) do

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.string "sport"
    t.integer "configuration"
    t.string "label"
    t.float "latitude"
    t.float "longitude"
    t.integer "wind_force_maxi"
    t.integer "wind_force_mini"
    t.string "wind_direction"
    t.integer "tide_mini"
    t.integer "tide_max"
    t.boolean "low_tide"
    t.boolean "mid_tide"
    t.boolean "high_tide"
    t.integer "coeff_mini"
    t.integer "coeff_maxi"
    t.integer "wave_direction"
    t.integer "wave_height_mini"
    t.integer "wave_height_maxi"
    t.integer "periode_mini"
    t.integer "periode_maxi"
    t.string "windfinder"
    t.string "windfindersuper"
    t.string "shom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
