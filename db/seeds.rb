# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
LottoType.create [{:name => 'Mega-Sena', :values => 6},
                  {:name => 'Lotofácil', :values => 15},
                  {:name => 'Quina', :values => 5},
                  {:name => 'Lotomania', :values => 20}]
                  
l = LottoType.all
l[0].results.create(:numbers => [23,27,30,37,38,44], :contest => 1361)
l[1].results.create(:numbers => [1,4,8,9,12,14,15,16,17,18,20,21,22,23,25], :contest => 712)
l[2].results.create(:numbers => [17,33,41,54,71], :contest => 2819)
l[3].results.create(:numbers => [1,7,16,17,24,26,35,40,41,45,47,53,54,55,64,67,71,72,90,94], :contest => 1217)