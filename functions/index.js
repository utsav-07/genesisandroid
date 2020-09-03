const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { firestore } = require('firebase-admin');
admin.initializeApp();

exports.myinfo = functions.https.onRequest((request, response) => {
    var val = JSON.parse(request.body);
    // console.log(request.body);
    var va  = [];
    return admin.auth().getUser(val.uid).then(user => {
      return  admin.firestore().collection('users').where('email', '==', user.email).get().then((snap) => {
                snap.forEach(da => {
                    va.push(da.data());
                });
        return response.send(JSON.stringify(va));
        }).catch((e) => {
            return console.log(e);
        });
    }).catch(e2 => {
        return console.log(e2);
    })

})


exports.fetchgroups = functions.https.onRequest((request, response) => {

    admin.firestore().collection('groups').get().then(e => {
        var val = [];
        e.forEach(el => {
            val.push(el.data());
        });
        return response.send(JSON.stringify(val));
        // console.log(_val);

    }).catch(e => {
        throw response.status(404);
    });

});

exports.createuser = functions.https.onRequest((request, response) => {
    var val = JSON.parse(request.body);

    admin.firestore().collection('users').add({
        'name': val.name,
        'rollNo': val.rollNo,
        'year': val.year,
        'branch': val.branch,
        'email': val.email,
        'groups': val.groups
    })
        .then((val) => {
            return response.send("Welcome to team Genesis");
        }

        ).catch(e => {
            return response.status(404);
        });

});
