const functions = require('firebase-functions');
const admin = require ('firebase-admin');

admin.initializeApp(functions.config().firebase);

const denunciaAnonima=admin.firestore().collection('denuncia_anonima');

function newID(length) {
    var result           = '';
    var characters       = 'ABDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }
 
 function newContactID (length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       if(i===length-1){
         result+='C';
       }
       else result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }

exports.createComplaint = functions.https.onCall( (data, context) => {

   var generatedId1 = newID(9);

   denunciaAnonima.doc(generatedId1).set({

      info        :  data.info,
      day         :  data.day,
      month       :  data.month,
      year        :  data.year,
      status      :  "init",
      time        :  data.time

   });

   return {id: generatedId1};

});

exports.testFuction = functions.https.onCall((data, context)=>{

   var generatedId1 = newID(9);

   denunciaAnonima.doc(generatedId1).set({

      info        :  data.info,
      day         :  data.day,
      month       :  data.month,
      year        :  data.year,
      status      :  "init",
      time        :  data.time,
      id          :  generatedId1,

   });

   return {id: generatedId1};

});