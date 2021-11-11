require('dotenv').config();

module.exports = {
    api:{
        port: process.env.PORT || 8080,
    },
    jwt: {
        secret: process.env.JWT_SECRET || 'notasecret!',
    },
    sqlserver:{
        dbUser:'adminsa',
        dbPassword:'Db_2021_Agua_S',
        dbServer:'dbdiraguasaneamiento.ctyjderc9fzr.us-east-2.rds.amazonaws.com',
        dbDatabase:'dbmuestras',
    },
    cloudinary:{
        cloud:'https://api.cloudinary.com/v1_1/municipalidad-san-jose-chacaya/image/upload',
        presets:'gg5gskkt'
    }
}





/*
module.exports = {
    api:{
        port: process.env.PORT || 8080,
    },
    jwt: {
        secret: process.env.JWT_SECRET || 'notasecret!',
    },
    sqlserver:{
        dbUser:process.env.DB_USUARIO,
        dbPassword:process.env.DB_PASSWORD,
        dbServer:process.env.DB_SERVER,
        dbDatabase:process.env.DB_DATABASE,
    },
    cloudinary:{
        cloud:process.env.CLOUDINARY_URL,
        presets:process.env.PRESETS
    }
}*/