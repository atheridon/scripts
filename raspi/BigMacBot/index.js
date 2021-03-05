const Discord = require('discord.js')
const client = new Discord.Client()

client.login('Nzg5ODgxMTk5NTc2NzQzOTc2.X94gMQ.wfiut_H3bqa_3kVZYzPtMar33zw')

client.once('ready', () => {
    console.log('BigMac bannt jeden weg!')
})

client.on('message', message => {
    // BigMac bann command
    if (message.content.startsWith("!BigMac bann") && message.content.endsWith("weg")) {
        if (!message.member.hasPermission("BAN_MEMBERS")) {
            message.reply("du hasch hier keine Rechte!")
        } else {
            if (message.mentions.members.first()) {
                const targetMember = message.guild.member(message.mentions.users.first()) 
                if (targetMember.hasPermission("ADMINISTRATOR") || targetMember.hasPermission("BAN_MEMBERS")) {
                    message.reply("dat kann isch nicht machen diese...")
                } else {
                    if (targetMember.ban({reason: "weil ich kann"})) {
                        message.reply("hab den weg gebannt.")
                    } else {
                        message.reply("kann den nischt bannen...")
                    }
                }
            } else {
                message.reply("du musch schon einen richtigen @user-to-ban angeben diese...")
            }
        } 
    }

    // BigMac kick command
    if (message.content.startsWith("!BigMac kick") && message.content.endsWith("raus")) {
        if (!message.member.hasPermission("KICK_MEMBERS")) {
            message.reply("du hasch hier keine Rechte!")
        } else {
            if (message.mentions.members.first()) {
                const targetMember = message.guild.member(message.mentions.users.first()) 
                if (targetMember.hasPermission("ADMINISTRATOR") || targetMember.hasPermission("KICK_MEMBERS")) {
                    message.reply("dat kann isch nicht machen diese...")
                } else {
                    if (targetMember.kick()) {
                        message.reply("hab den raus gekickt.")
                    } else {
                        message.reply("kann den nischt kicken...")
                    }
                }
            } else {
                message.reply("du musch schon einen richtigen @user-to-kick angeben diese...")
            }
        } 
    }
})