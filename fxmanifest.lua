fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'  
} 

client_scripts {
    'client/*.lua'
}

escrow_ignore {
    'config.lua'
}