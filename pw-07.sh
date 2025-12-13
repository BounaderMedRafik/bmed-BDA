#   1. User Management and Access Rights
db.createUser({
  user: "gerant",
  pwd: "gerant123",
  roles: [
    { role: "readWrite", db: "banque" }
  ]
})

mongosh -u gerant -p gerant123 --authenticationDatabase banque

#   2. Creation of Collections and Initial Data
use banque
db.comptes.insertMany([
  { _id: "COMPTE_A", client: "Alice", solde: 1000, devise: "DA" },
  { _id: "COMPTE_B", client: "Bob", solde: 500, devise: "DA" },
  { _id: "COMPTE_C", client: "Charlie", solde: 200, devise: "DA" }
])

#   3. Money Transfer Operation

db.createCollection("transactions")
db.comptes.updateOne(
    { _id: "COMPTE_A" },
    { $inc: { solde: -100 } }
  );

  db.comptes.updateOne(
    { _id: "COMPTE_B" },
    { $inc: { solde: 100 } }
  );

  db.transactions.insertOne({
    from: "COMPTE_A",
    to: "COMPTE_B",
    montant: 100,
    devise: "DA",
    date: new Date()
  });

db.comptes.find().pretty()

#   6.3 Read-Only User (Auditor)
db.createUser({
  user: "auditeur",
  pwd: "audit123",
  roles: [
    { role: "read", db: "banque" }
  ]
})




