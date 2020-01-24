class SpotifyIdArtistsList {
  static List<String> globalArtistIds = [
    '6eUKZXaKkcviH0Ku9w2n3V', // Ed Sheeran
    '246dkjvS1zLTtiykXe5h60', // Post Malone
    '4nDoRrQiYLoBzwC5BhVJzF', // Camila Cabello
    '6LuN9FCkKOj5PcnpouEgny', // Khalid
    '1vyhD5VmyZ7KMfW5gqLgo5', // J Balvin
    '7n2wHs1TKAczGzO7Dd2rGr', // Shawn Mendes
    '1uNFoZAHBGtllmzznpCI3s', // Justin Bieber
    '4VMYDCV2IEDYJArk749S6m', // Daddy Yankee
    '66CXWjxzNUsdJxJ2JdwvnR', // Ariana Grande
    '6qqNVTkY8uBg9cP3Jd7DAH', // Billie Eilish
    '3TVXtAsR1Inumwj472S9r4', // Drake
    '69GGBxA162lTqCwzJG5jLp', // The Chainsmokers
    '64KEffDW9EtZ1y2vBYgq8T', // Marshmello
    '7jVv8c5Fj3E9VhNjxT4snq', // Lil Nas X
    '06HL4z0CvFAxyc27GXpf02', // Taylor Swift
    '1zNqQNIdeOUZHb8zbZRFMX', // Swae Lee
    '4q3ewBCX7sLwd24euuV69X', // Bad Bunny
    '53XhwfbYqKCa1cC15pYq2q', // Imagine Dragons
    '6jJ0s89eD6GaHleKKya26X', // Katy Perry
    '2NjfBq1NflQcKSeiDooVjY', // Tones and I
    '4gzpq5DPGxSnKTe4SA8HAU', // Coldplay
    '711MCceyCBcFnzjGY4Q7Un', // AC/DC
    '6wWVKhxIU2cEi0K81v7HvP', // Rammstein
    '79bxUQsBIXO8nVLB9fYKf7', // Modern Talking
    '4bL2B6hmLlMWnUEZnorEtG', // Felix Jaehn
    '3t5xRXzsuZmMDkQzgOX35S', // Robin Schulz
    '3WrFJ7ztbogyGnTHbHJFl2', // Beatles
    '0k17h0D3J5VfsdmQ1iZtE9', // Pink Floyd
    '22bE4uQ6baNwSHPVcDxLCe', // The Rolling Stones
    '2DaxqgrOhkeH0fpeiQq2f4', // Oasis
    '1dfeR4HaWDbWqFHLkxsg1d', // Queen
    '2ye2Wgw4gimLv2eAKyk1NB', // Metallica
    '7oPftvlwr6VrsViSDV7fJY', // Green Day
    '7dGJo4pcD2V6oG8kP0tJRR', // Eminem
    '5K4W6rqBFWDnAN6FQUkS6x', // Kayne West
    '0hCNtLu0JehylgoiP8L4Gh', // Nicki Minaj
    '0jnsk9HBra6NMjO2oANoPY', // Flo Rida
  ];

  // Künstler Quelle: https://de.wikipedia.org/wiki/Liste_der_deutschen_Nummer-eins-Hits_im_Ausland
  static List<String> germanArtistIds = [
    '7e52Ytzjj1q71DUj2cSlch', // Sarah Connor
    '3GbUWWI1rMwAIPbUVPvnPA', // Silbermond
    '0cbL6CYnRqpAxf1evwUVQD', // Die Ärzte
    '27T030eWyCQRmDyuvr1kxY', // Scorpions
    '6wWVKhxIU2cEi0K81v7HvP', // Rammstein
    '748dDObrUoBetes0pLj788', // Die Fantastischen Vier
    '5PwcOudItUhq3ciF9QwaXZ', // Sportfreunde Stiller
    '0dmPX6ovclgOy8WWJaFEUU', // Kraftwerk
    '0HlxL5hisLf59ETEPM3cUA', // Scooter
    '2F8GvYuY0lfZNYu45dY6gJ', // Die Toten Hosen
    '7LdEfCVOGOJ2jaAxsmnTeN', // Spider Murphy Gang
    '0xliTEbFfy5HQHvsTknTkX', // Alphaville
    '6x9jRPDmA8Ihpw3A9FBowD', // Böhse Onkelz
    '79bxUQsBIXO8nVLB9fYKf7', // Modern Talking
    '46aNfN89JrOQTCy97GoCHa', // Tokio Hotel
    '6Tz0QRoe083BcOo2YbG9lV', // Nena
    '3DmG65yHQsMms7WAvrZOdt', // Enigma
    '3vRclCt9VnNhYIxFMQCxuM', // Milli Vanilli
    '3t5xRXzsuZmMDkQzgOX35S', // Robin Schulz
    '54R6Y0I7jGUCveDTtI21nb', // Boney M.
    '5UyJW2eCOuXtyYftgbMxZG', // James Last
    '1g1nVvle9qO9AWIUWYvPAP', // Dschinghis Khan
    '4bL2B6hmLlMWnUEZnorEtG', // Felix Jaehn
    '5W3s4beu23rOlseCbVOp4l', // Peter Maffay
    '7MzHPIXAqIOCnvK0sVY72W', // Helene Fischer
    '7J8A1bNBCuikXoOOetFCKz', // Beatrice Egli
    '5slpk6nu2IwwKx0EHe3GcL', // Lena Meyer-Landrut
    '3Ek1EdkcbRFvSDJj9j5JXQ', // The Baseballs
    '01e2lCvLZ4fLUIRy68nptH', // Wankelmut
    '0YC192cP3KPCRWx8zr8MfZ', // Hans Zimmer
    '1uphmI1bErhHslREq9QusL', // Roland Kaiser
    '5tG5dl5mS2wB5w72YBpsyg', // Herbert Grönemeyer
    '47RPLpnGhBRTjQrRBOev9s', // Xavier Naidoo
    '4Yttlv9ndGjCDCVLqM7ACq', // Sido
    '7xCzwxwDwXTTCtjcWBoNow', // Söhne Mannheims
    '2nacZFQ7nlwSw4RpsZlbpP', // Rosenstolz
    '6rqlONGmPuP2wJVSfliLBI', // Peter Fox
    '3c96G4d2lUOxhomM2mby5S', // Bushido
    '6f1kv0aUPG9I0Rp3dmLCPi', // Unheilig
    '3utZ2yeQk0Z3BCOBWP7Vlu', // Cro
    '6gto7HVNhu4ARE3P3g8Y5Y', // Kollegah
    '2JwyRtuXf2l6sTnSnGVIa1', // Farid Bang
    '6UDhlW8uEVBBrqHS3RrKuv', // Casper
    '1sICjVlCMOCah0snHXWUz0', // The BossHoss
    '23xqmJEN3oVxwzqtNIyR5m', // AnnenMayKantereit
    '4WZGDpNwrC0vNQyl9QzF7d', // Capital Bra
    '5bKy7Tu2BNmfoFnDC5mncZ', // Yvonne Catterfeld
    '3RRODs1rHC2ktLqyDDfgPH', // Fettes Brot
    '7qXzy6c5RWT0XlVQcOBIDG', // Mark Forster
    '3rZBkgoRHG8M9jQL0QPNMi', // Adel Tawil
    '13bDjug9N0pyv3ZUINjkDV', // Bausa
    '1hzfo8twXdOegF3xireCYs', // Milky Chance
    '4VH2QabEORUUhN1F1cYQ6N', // Reamonn
    '4KivBMgSnZ7hCDfPm46fKc', // Jan Delay
    '0rasA5Z5h1ITtHelCpfu9R', // Paul Kalkbrenner
    '49eo9xE4yGzJLWkOndiODs', // Deichkind
    '6VjbeCqoayiHYnefrisskv', // Kay One
    '387fj6TuPJ3y2H8ViAm6r0', // Pietro Lombardi
    '2UFKXTZgKtOTHSqMSyAcLO', // Glasperlenspiel
    '08Ut1tYxtmgIInVyQqohkM', // Fritz Kalkbrenner
    '0N0d3kjwdY2h7UVuTdJGfp', // Cascada
    '46lnlnlU0dXTDpoAUmH6Qx', // Lou Bega
    '0BZ3BHzfYwpd3k5TDnvAz8', // Culture Beat
  ];

  static List<String> greatBritainArtistIds = [
    '3WrFJ7ztbogyGnTHbHJFl2', // Beatles
    '0k17h0D3J5VfsdmQ1iZtE9', // Pink Floyd
    '22bE4uQ6baNwSHPVcDxLCe', // The Rolling Stones
    '2DaxqgrOhkeH0fpeiQq2f4', // Oasis
    '1dfeR4HaWDbWqFHLkxsg1d', // Queen
    '4gzpq5DPGxSnKTe4SA8HAU', // Coldplay
    '6mdiAmATAx73kdxrNrnlao', // Iron Maiden
    '7bu3H8JO7d0UbMoVzbo70s', // The Cure
    '3RGLhK1IP9jnYFH4BRFJBS', // The Clash
    '7MhMgCo0Bl0Kukl93PZbYS', // Blur
    '5M52tdBnJaKSvOpJGz8mfZ', // Black Sabbath
    '67ea9eGLXYMsO2eYQRui3w', // The Who
    '12Chz98pHFMPJEknJQMWvI', // Muse
    '7Ln80lUS6He07XvHI8qqHH', // Arctic Monkeys
    '1moxjboGR7GNWYIMWsRjgG', // Florence + The Machine
    '3CkvROUTQ6nRi9yQOcsB50', // Genesis
    '36QJpDe2go2KgaRleHCDTp', // Led Zeppelin
    '5NGO30tJxFlKixkPSgXcFE', // The Police
    '568ZhdwyaiCyOGJRtNYhWf', // Deep Purple
    '4Z8W4fKeB5YxbusRsdQVPb', // Radiohead
    '7KMqksf0UMdyA0UCf4R3ux', // James Blunt
  ];

  static List<String> americaArtistIds = [

  ];

  static List<String> eightyArtistIds = [
    '1dfeR4HaWDbWqFHLkxsg1d', // Queen
    '5NGO30tJxFlKixkPSgXcFE', // The Police
    '3qm84nBOXUEQ2vnTfUTTFC', // Guns N' Roses
    '6mdiAmATAx73kdxrNrnlao', // Iron Maiden
    '0lZoBs4Pzo7R89JM9lxwoT', // Duran Duran
    '711MCceyCBcFnzjGY4Q7Un', // AC/DC
    '2cnMpRsOVqtPMfq7YiFE6K', // Van Halen
    '6H1RjVyNruCmrBEWRbD0VZ', // Def Leppard
    '0WwSkZ7LtFUFjGjMZBMt6T', // Dire Straits
    '3CkvROUTQ6nRi9yQOcsB50', // Genesis
    '6kz53iCdBSqhQCZ21CoLcc', // Culture Club
    '2x9SpqnPi8rlE9pjHBwmSC', // Talking Heads
    '77tT1kLj6mCWtFNqiOmP9H', // Daryl Hall & John Oates
    '7bu3H8JO7d0UbMoVzbo70s', // The Cure
    '0rvjqX7ttXeg3mTy8Xscbt', // Journey
    '7A9yZMTrFZcgEWAX2kBfK6', // Huey Lewis & The News
    '0NKDgy9j66h3DLnN8qu1bB', // Eurythmics
    '762310PdDnwsDxAQxzQkfX', // Depeche Mode
    '4bthk9UfsYUYdcFyqxmSUU', // Tears for Fears
    '0PFtn5NtBbbUNbU9EAmIWF', // Toto
    '2jzc5TC5TVFLXQlBNiIUzE', // A-ha
    '0SD4eZCN4Kr0wQk56hCdh2', // Bonnie Tyler
    '3PhoLpVuITZKcymswpck5b', // Elton John
    '2ye2Wgw4gimLv2eAKyk1NB', // Metallica
  ];

  static List<String> ninetyArtistIds = [
    '5rSXSAkZ67PYJSvpUpkOr7', // Backstreet Boys
    '0uq5PttqEjj3IH1bzwcrXF', // Spice Girls
    '6olE6TJLqED3rqDCT0FyPh', // Nirvana
    '1w5Kfo2jwwIPruYS2UWh56', // Pearl Jam
    '7jy3rLJdDQY21OgRLCZ9sD', // Foo Fighters
    '4KWTAlx2RvbpseOGMEmROg', // R.E.M.
    '0L8ExT028jH3ddEcZwqJJ5', // Red Hot Chili Peppers
    '4Z8W4fKeB5YxbusRsdQVPb', // Radiohead
    '03r4iKL2g2442PT9n2UKsx', // Beastie Boys
    '2DaxqgrOhkeH0fpeiQq2f4', // Oasis
    '0TImkz4nPqjegtVSMZnMRq', // TLC
    '40Yq4vzPs9VNUrIBG5Jr2i', // The Smashing Pumpkins
    '7MhMgCo0Bl0Kukl93PZbYS', // Blur
    '0cQbJU1aAzvbEmTuljWLlF', // No Doubt
    '51Blml2LZPmy7TTiAg47vQ', // U2
    '2UazAtjfzqBF0Nho2awK4z', // Stone Temple Pilots
    '0X380XXQSNBYuleKzav5UO', // Nine Inch Nails
    '7t0rwkOPGlDPEhaOcVtOt9', // The Cranberries
    '7oPftvlwr6VrsViSDV7fJY', // Green Day
    '1XgFuvRd7r5g0h844A5ZUQ', // Take That
  ];

  static List<String> rockArtistIds = [
    '711MCceyCBcFnzjGY4Q7Un', // AC/DC
    '3WrFJ7ztbogyGnTHbHJFl2', // Beatles
    '22bE4uQ6baNwSHPVcDxLCe', // The Rolling Stones
    '36QJpDe2go2KgaRleHCDTp', // Led Zeppelin
    '6olE6TJLqED3rqDCT0FyPh', // Nirvana
  ];

  static List<String> rapArtistIds = [
    '7dGJo4pcD2V6oG8kP0tJRR', // Eminem
    '1ZwdS5xdxEREPySFridCfh', // 2Pac
    '5me0Irg2ANcsgc93uaYrpb', // The Notorious B.I.G.
    '3q7HBObVc0L8jNeTe5Gofh', // 50 Cent
    '3nFkdlSjzX9mRTtwJOzDYB', // Jay-Z
    '3Mcii5XWf6E0lrY3Uky4cA', // Ice Cube
    '7hJcb9fa4alzcOq3EaNPoG', // Snoop Dogg
    '6DPYiyq5kWVQS4RGwxzPC7', // Dr. Dre
    '20qISvAhX20dpIbOOzGK3q', // Nas
    '55Aa2cqylxrFIXC767Z865', // Lil Wayne
    '5K4W6rqBFWDnAN6FQUkS6x', // Kayne West
    '3TVXtAsR1Inumwj472S9r4', // Drake
    '2RdwBSPQiwcmiDo9kixcl8', // Pharrell Williams
    '2YZyLoL8N0Wb9xBt1NhZWg', // Kendrick Lamar
    '13y7CgLHjMVRMDqxdx0Xdo', // Gucci Mane
    '0c173mlxpT3dSFRgMO8XPh', // Big Sean
    '0hCNtLu0JehylgoiP8L4Gh', // Nicki Minaj
    '0jnsk9HBra6NMjO2oANoPY', // Flo Rida
    '3aQeKQSyrW4qWr35idm0cy', // T-Pain
    '137W8MRPWKqSmrBGDBFSop', // Wiz Khalifa
  ];
}
