const Sector7slums = artifacts.require('Sector7slums')
const TOKENID = 0
module.exports = async callback => {
    const s7s = await Sector7slums.deployed()
   console.log("Setting tokenURI")
    const tx0 = await s7s.setTokenURI(0, "https://ipfs.io/ipfs/QmeVECWABfb3caodUCnen8NhHVwGkLhH1icfRQo4yywrPZ?filename=Aerith-01.json")
    const tx1 = await s7s.setTokenURI(1, "https://ipfs.io/ipfs/QmP4uVvHcaVW5zEiiQvr1UfyjWdcTJK7Jtw2qQfc1Lrs2y?filename=Aerith-02.json")
    const tx3 = await s7s.setTokenURI(3, "https://ipfs.io/ipfs/Qmep3joWws3VN4Zen3jHFbt3TQpm3xsAqKiuQXqhXCgRPc?filename=Aerith-03.json")
    const tx4 = await s7s.setTokenURI(4, "https://ipfs.io/ipfs/QmSJ5y9iRssewb5ywjzmKmRpGDhhWQkaTESQkz9sbmW21x?filename=Aerith-04.json")
    const tx5 = await s7s.setTokenURI(5, "https://ipfs.io/ipfs/QmXZB53XQtNfd8wBBMBpzWLqb5sXaLtL8AizJV2JavtasJ?filename=Aerith-05.json")
    const tx6 = await s7s.setTokenURI(6, "https://ipfs.io/ipfs/QmTRjZ39EWpNtsSLF7LQuWxbDhCxQxp2p9XwT2TVuQaJgF?filename=Aerith-06.json")
    const tx7 = await s7s.setTokenURI(7, "https://ipfs.io/ipfs/QmZHEf7i3bfVr4Chnbo7nYksj8bBXXqVysguB7GVnDTKQu?filename=Aerith-07.json")
    const tx8 = await s7s.setTokenURI(8, "https://ipfs.io/ipfs/QmZHEf7i3bfVr4Chnbo7nYksj8bBXXqVysguB7GVnDTKQu?filename=Aerith-07.json")
    const tx9 = await s7s.setTokenURI(9, "https://ipfs.io/ipfs/QmbRHB9Bp5JhDRaFF596W86wMq9LomUgcLBRpq4cLvdLy9?filename=Aerith-09.json")
    const tx10 = await s7s.setTokenURI(10, "https://ipfs.io/ipfs/QmTUpV57LRVcVWCKm48RymGrd469RY7bAZG8ZdyQNhegR7?filename=Aerith-10.json")
    console.log(tx)
    callback(tx.tx)
}