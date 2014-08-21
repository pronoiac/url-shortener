# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TagTopic.create!(category: "News")
TagTopic.create!(category: "Music")
TagTopic.create!(category: "Sports")

Tagging.create!(tag_topic_id: 1, url_id: 1)
Tagging.create!(tag_topic_id: 2, url_id: 2)
Tagging.create!(tag_topic_id: 3, url_id: 3)
