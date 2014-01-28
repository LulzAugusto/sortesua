desc "This task is called by the Heroku scheduler add-on"
task :update_results => :environment do
    puts "Updating results..."
    puts "now trying to update Lotofacil..."
    Result.updates_lotofacil
    puts "now trying to update DuplaSena..."
    Result.updates_duplasena
    puts "now trying to update Lotomania..."
    Result.updates_lotomania
    puts "done."
end