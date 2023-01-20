namespace :dev do

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") {%x(rails db:drop)}
      show_spinner("Criando DB...") {%x(rails db:create)}
      show_spinner("Migrando DB...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas...")
      spinner.auto_spin
      coins = [
        {	description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://thumbs.dreamstime.com/b/moeda-de-ouro-do-bitcoin-em-um-fundo-branco-99603983.jpg",
        mining_type: MiningType.where(acronym:'PoW').last
        },
        {	description: "Ethereum",
        acronym: "ETH",
        url_image: "https://thumbs.dreamstime.com/b/moeda-de-ethereum-eth-isolada-no-fundo-branco-rendi%C3%A7%C3%A3o-d-104206035.jpg",
        mining_type: MiningType.all.sample
        },
        {	description: "Dash",
        acronym: "DASH",
        url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXO6fbQCWzxxrW38hu-PiEu0jln-2tx9OfmcBL6bDNUf43sdXO9PE1yCiSFUdLkQwz6F0&usqp=CAU",
        mining_type: MiningType.all.sample
        },
        {	description: "Iota",
        acronym: "IOT",
        url_image: "https://avatars.githubusercontent.com/u/20126597?s=280&v=4",
        mining_type: MiningType.all.sample
        },
        {	description: "ZCash",
        acronym: "ZEC",
        url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1437.png",
        mining_type: MiningType.all.sample
        }
      ]
      
      coins.each do |coin|
        sleep(1)
      Coin.find_or_create_by!(coin)
      end
    end 
  end  

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando os tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
      mining_types.each do |mining_type|
        sleep(1)
        MiningType.find_or_create_by!(mining_type)
      end
    end  
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}...")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})") # Stop animation
  end
  
end
