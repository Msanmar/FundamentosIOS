//
//  Repository.swift
//  Westeros
//
//  Created by Alexandre Freire on 13/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
    
    typealias HouseFilter = (House) -> Bool  // (Tipo param) -> Tipo return
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    var seasons: [Season] { get }
    
   func season(named: String) -> Season?
    
    typealias SeasonFilter = (Season) -> Bool
    func seasons(filteredBy: SeasonFilter) -> [Season]
    
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    var houses: [House] {
        
        // Creación de las casas
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "stark")!)
        let lannisterSigil = Sigil(description: "León Rampante", image: UIImage(named: "lannister")!)
        let targaryenSigil = Sigil(description: "Dragón tricéfalo", image: UIImage(named: "targaryen")!)
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let lannisterHouse = House(
            name: "Lannister",
            sigil: lannisterSigil,
            words: "Oye mi rugido",
            url: lannisterURL
        )
        
        let starkHouse = House(
            name: "Stark",
            sigil: starkSigil,
            words: "Se acerca el invierno",
            url: starkURL
        )
        
        let targaryenHouse = House(
            name: "Targaryen",
            sigil: targaryenSigil,
            words: "Fuego Y Sangre",
            url: targaryenURL
        )
        
        // Creación de los personajes y adición a las casas
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "La Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    
    var seasons: [Season] { //propiedad calculada que devuelve las 7 primeras temporadas ordenadas, con sus episodios
        
        // Creamos las siete primeras temporadas
        let season1 = Season(seasonNumber: 1 ,totalEpisodes: 10,  releaseDate: formatDateAsString(dateAsString: "17-04-2011")!, summary: "El rey Robert Baratheon de los Siete Reinos viaja al Norte para ofrecerle a su viejo amigo Eddard «Ned» Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. Tras aceptar el cargo, este viaja a Desembarco del Rey con sus hijas, Sansa -que se promete con el hijo del rey, Joffrey- y Aria. Allí descubre uno de los secretos por los que la antigua Mano del Rey ha sido asesinada: los hijos del rey Robert no son suyos, son de Jaime Lannister. Sin embargo, cuando está a punto de desvelárselo, muere.Ned utiliza su título de rey regente para que Joffrey no llegue al trono, aunque le tienden una trampa, lo encarcelan por traición y, finalmente, Joffrey termina ejecutándolo. Cuando Robb se entera de la ejecución de su padre, va en su rescate. Mientras, Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche y tomar sus votos.Al otro lado del Mar Angosto, el príncipe exiliado Viserys Targaryen ofrece a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército para recuperar el Trono de Hierro. Tras la boda, Viserys amenzada la seguridad de la khaleesi, que está embarazada, por lo que Drogo acaba con su vida. Sin embargo, este matrimonio es la perdición del Khal que, tras enfrentarse a sus compañeros por el liderazgo del grupo dothraki, recibe un corte mortal. Daenerys intenta salvarlo recurriendo a una maga que lo deja es estado vegetativo y hace que pierda a su hijo. Lo único que le queda ya a la joven Targaryen son sus tres huevos de dragón petrificados, los cuales nacen tras quemarse junto a su marido y salir ilesa.")
        
        let season2 = Season(seasonNumber: 2, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "01-04-2012")!, summary: "Después del final de primera temporada, la guerra entre familias no ha hecho más que comenzar. En el Norte, Robb Stark se entera de la muerte de su padre Ned por mandato de los Lannister y les declara la guerra. Así, el hijo mayor de los Stark captura a Jaime Lannister, haciéndole prisionero. Pero su madre, Catelyn Stark, decide liberlarle para intercambiarlo por sus hijas, Sansa y Arya. Sansa sigue atrapada en Desembarco del Rey a merced de Joffrey, el nuevo Rey, que no duda en torturarla y hacerle la vida imposible. Mientras, Arya Stark, la hija pequeña, sigue huida y en compañía de Gendry Baratheon, hijo secreto del Rey Robert. Pero Robb Stark no es el único en declararle la guerra a los Lannister: los hermanos Baratheon, Renly y Stannis, se creen cada uno con derecho al Trono de Hierro. Mientras Renly se autproclama Rey, Stannis acude a Melisandre, una sacerdotisa veneradora del Señor de la Luz para que le ayude a hacerse con el Trono. Renly toma como escudera a Brienne de Tarth, y como amante a Loras Tyrell. Pero es asesinado una noche en su tienda personal por un demonio sombra... al que ha dado luz Melisandre por mandato de Stannis Baratheon. Daenerys, que ha huido del territorio dothraki, vaga por el desierto junto a sus dragones y a su consejero Jorah Mormont hasta que llegan a la ciudad de Qarth. Allí, los nobles de la ciudad tratan de hacerse con sus dragones (obviamente, no lo consiguen).En el Norte, Theon Greyjoy, amigo de los Stark desde la infancia, aprovecha que Robb no está para hacerse con el poder. Finge haber matado a los hijos pequeños de los Stark, Rickon y Bran, que huyen con Hodor, su criado, y Osha, una salvaje.Más allá del Muro, los salvajes se están acercando cada vez más, ya que huyen de los conocidos como Caminantes Blancos, un ejército de no-muertos. En una expedición, Jon Nieve y su amigo Sam se cruzan con estos caminantes. Jon conoce a Ygritte, una salvaje, y ambos se enamoran.En Desembarco del Rey, Cersei Lannister, que teme ataques contra la ciudad, busca alianzas en otras familias y da con los Tyrell, de Alto Jardín. Margaery Tyrell, que era prometida de Renly Baratheon, se convierte en la prometida de Joffrey. Mientras, Jaime Lannister es escoltado por Brienne de Tarth (que se ha convertido en escudera de Catelyn Stark) hacia Desembarco del Rey.Stannis Baratheon, a instancias de Melisandre, acaba por atacar Desembarco del Rey con todo su ejército, a través de la bahía de Aguasnegras que rodea la ciudad. Tyrion Lannister, que conoce la existencia de reservas de fuego valyrio en la ciudad, lo usa para derrotar a Stannis, que pierde casi todos sus hombres en la llamada Batalla de Aguasnegras.")

        
        let season3 = Season(seasonNumber: 3, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "31-03-2013")!, summary: "Después de lo sucedido en primera temporada y, sobre todo, la batalla de Aguasnegras, final de la segunda temporada, la guerra por el Trono de Hierro es inminente. Pero no solo tratarán de conquistarlo los vivos... ya que entran en el juego los Caminantes Blancos. Robb Stark, Rey del Norte, debía casarse con una de las hijas de Walder Frey, para así mantener su alianza con los Frey y los Bolton, pero al final se compromete con Talisa Maegyr, que espera su primer hijo. Tras esta traición, los Bolton, los Frey y los Lannister conspiran para asesinarlo, matando durante la conocida como 'Boda Roja' tanto a Robb como a Talisa y a Catelyn Stark. Arya Stark llega tarde y descubre el asesinato de su familia, pero es encontrada por Sandor Clegane, 'El Perro', y se la lleva de allí para que no la descubran.  Mientras, en Desembarco del Rey, Tyrion es obligado a casarse con Sansa Stark, por orden directa de Tywin Lannister y Joffrey. Además, avisa a Cersei que tendrá que casarse con Loras Tyrell para mantener la alianza con la casa Tyrell. Pero Petyr Baelish (Meñique), propone a Sansa huir de Desembarco del Rey al Nido de Águilas, muy lejos de allí, gobernado por su tía, la hermana de Catelyn Stark. Daenerys Targaryen viaja a Astapor y allí, al ver la cantidad de esclavos que pueblan la ciudad, decide liberarlos y asesinar a sus amos. Además, en aras de crear un gran ejército para alzarse como Reina en el Trono de Hierro, compra a los Inmaculados, comandados por Gusano Gris. Ahora Daenerys no solo es conocida como 'Madre de Dragones' sino también como 'Rompedora de Cadenas'. Jaime Lannister, que sigue su camino hacia Desembarco del Rey, escoltado por Brienne de Tarth, pierde la mano. Roose Bolton, tras el asesinato de Robb Stark, se alza como Rey del Norte, mientras su hijo bastardo, Ramsay, sigue torturando a Theon Greyjoy, le castra y le manipula de tal forma la mente que acaba despojándole de su propia identidad para terminar llamándole 'Hediondo'.Stannis Baratheon, herido en su orgullo por haber perdido la batalla de Aguasnegras, cede todo el poder a Melisandre. Pero su consejero, ser Davos, ve el peligro y trata de matarla. Stannis, totalmente cegado por Melisandre, apresa a ser Davos. Más allá del Muro, Jon escala el Muro con varios salvajes, pero cuando le piden que asesine a uno de la Guardia de la Noche para comprobar su compromiso con los salvajes, huye. Ygritte le dispara... pero finalmente le deja ir, porque sigue enamorada de él.")
        
        let season4 = Season(seasonNumber: 4, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "06-04-2014")!, summary: "Season 4 summary")
        let season5 = Season(seasonNumber: 5, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "12-04-2015")!, summary: "Season 5 summary")
        let season6 = Season(seasonNumber: 6, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "24-04-2016")!, summary: "Season 6 summary")
        let season7 = Season(seasonNumber: 7, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "16-07-2017")!, summary: "Season 7 summary")
        
        
        // Creamos los tres primeros episodios de la temporada 1 + episodio 10
        let epi1S1 = Chapter(title: "Winter is coming", launchingDate: formatDateAsString(dateAsString: "17-04-2011")!, episodeNumber: 1, season: season1, director: "Tim Van Patten", summary: "Eddard Stark, señor de Invernalia, recibe un aviso de un desertor de la Guardia de la Noche: los muertos han sido avistados. Por otra parte, Ned recibe una proposición de su amigo, el Rey Robert Baratheon: su mano, Jon Arryn, ha fallecido y desea que Ned le releve en el cargo; algo que provocaría que Eddard abandonase Invernalia y a algunos miembros de su familia.")
        let epi2S1 = Chapter(title: "The Kingsroad", launchingDate: formatDateAsString(dateAsString: "24-04-2011")!, episodeNumber: 2, season: season1, director: "Tim Van Patten", summary: "Ned Stark abandona Invernalia, acompañado de sus hijas, Sansa y Aria. Esta última aún tiene que resolver el conflicto entre su loba y el príncipe Joffrey. Mientras tanto, Jon Nieve viaja hacia el Muro y un inesperado compañero le acompañará en el trayecto. Daenerys, por su parte, busca vías para dar placer a Khal Drogo.")
        let epi3S1 = Chapter(title: "Lord Snow", launchingDate: formatDateAsString(dateAsString: "01-05-2011")!, episodeNumber: 3, season: season1, director: "Brian Kirk", summary: "Tras llegar a Invernalia, Ned no tarda en darse cuenta del mal manejo que se está ofreciendo a la capital de los Reinos. Catelyn ha viajado tras su marido para advertirle del peligro que sufre su casa. Jon debe integrarse a una nueva vida en el Muro, donde el linaje no tiene ninguna importancia. Daenerys recibe una sorprendente revelación; que provocará un cambio en la relación con su hermano.")
        let epi10S1 = Chapter(title: "Fire and Blood", launchingDate: formatDateAsString(dateAsString: "19-06-2011")!, episodeNumber: 10, season: season1, director: "Alan Taylor", summary: "Resumen episodio10 Season 1")
        
        // Creamos los tres primeros episodios de la temporada 2
        let epi1S2 = Chapter(title: "The north remembers", launchingDate: formatDateAsString(dateAsString: "01-04-2012")!, episodeNumber: 1, season: season2, director: "Alan Taylor", summary: "Mientras Robb Stark y su ejército norteño se preparan para la guerra contra los Lannister, Tyrion llega a Desembarco del Rey para aconsejar e intentar controlar al joven rey Joffrey. En Rocadragón, Stannis Baratheon planea su estrategia para reclamar el trono de su difunto hermano, aliándose con la misteriosa sacerdotisa Melisandre. Más allá del mar, Daenerys, junto con sus jóvenes dragones y su diezmado khalasar, intenta cruzar una vasta y seca extensión de terreno tratando de encontrar aliados o víveres. Más allá del Muro, Jon Nieve y la Guardia de la Noche tienen que pedir refugio a un desagradable salvaje.")
        let epi2S2 = Chapter(title: "The night lands", launchingDate: formatDateAsString(dateAsString: "08-04-2012")!, episodeNumber: 2, season: season2, director: "Alan Taylor", summary: "Tras la matanza sucedida en la capital, Tyrion intenta que Cersei aprenda una lección. De camino al Norte, Arya comparte un secreto con Gendry. Uno de los exploradores de Daenerys regresa. Después de nueve años con los Stark, Theon Greyjoy se reúne con su padre, Balon. Davos intenta que el pirata Salladhor Saan se ponga al servicio de Stannis y Melisandre para una posible invasión naval a Desembarco del Rey.")
        let epi3S2 = Chapter(title: "What Is Dead May Never Die", launchingDate: formatDateAsString(dateAsString: "15/04/2012")!, episodeNumber: 3, season: season2, director: "Alik Shakharov", summary: "Lo que está muerto no puede morir. En la Fortaleza Roja, Tyrion planea tres alianzas con una promesa de matrimonio. Craster se enfrenta a Jon Nieve por su atrevimiento. Catelyn llega al asentamiento del rey Renly a ofrecerle un pacto. En Invernalia, el maestre Luwin intenta descifrar los sueños de Bran.")
        
        // Creamos los tres primeros de la temporada 3
        let epi1S3 = Chapter(title: "Valar Dohaeris", launchingDate: formatDateAsString(dateAsString: "31-03-2013")!, episodeNumber: 1, season: season3, director: "Daniel Minahan", summary: "Samwell Tarly, el lord comandante Mormont y un grupo reducido de la Guardia de la Noche logran salvarse del ataque de los espectros. Jon llega al campamento de los salvajes y habla con Mance Rayder. Tyrion tiene una conversación con su padre y le hace una demanda. Margaery Tyrell comienza a cimentar su camino como futura reina. Robb y su ejército llegan a un devastado Harrenhal. Daenerys desembarca en Astapor y recibe varias sorpresas.")
        
        let epi2S3 = Chapter(title: " Alas negras, palabras negras", launchingDate: formatDateAsString(dateAsString: "07-04-2013")!, episodeNumber: 2, season: season3, director: "Daniel Minahan", summary: "Bran Stark encuentra a dos nuevos acompañantes en su camino al Muro. Sansa conversa con Olenna Tyrell, quien le pide que le diga la verdad sobre Joffrey. Shae le comunica a Tyrion la amenaza que para Sansa significa lord Baelish. Los salvajes continúan su marcha al Sur, al igual que los supervivientes de la Guardia de la Noche. Robb recibe dos malas noticias y, en las Tierras de la Corona, Jaime roba una de las espadas de Brienne e intenta escapar.")
        
        let epi3S3 = Chapter(title: "Walk of punishment", launchingDate: formatDateAsString(dateAsString: "14-04-2013")!, episodeNumber: 3, season: season3, director: "David Benioff", summary: "Catelyn asiste al funeral de su padre en Aguasdulces junto con Robb. Jon es enviado a una importante misión junto con Tormund Matagigantes. Los supervivientes de la Guardia de la Noche llegan a la cabaña de Craster. Petyr Baelish es enviado al Nido de Águilas y Tyrion debe tomar su lugar como Consejero de la Moneda. Melisandre deja Rocadragón. Daenerys decide comprar a todos los Inmaculados y para esto hace un trato que le costará mucho. Theon, con la ayuda de un desconocido, logra escapar. Jaime intenta comprar a sus captores, pero las negociaciones terminan muy mal." )

        // Creamos los tres primeros de la temporada 4
        let epi1S4 = Chapter(title: "Two Sords", launchingDate: formatDateAsString(dateAsString: "06-04-2014")!, episodeNumber: 1, season: season4, director: "D.B. Weiss", summary: "Tywin Lannister regala a su hijo Jaime, nuevo comandante de la Guardia Real, una espada de acero valyrio. Tyrion y Bronn reciben al díscolo príncipe Oberyn Martell, que busca venganza por las afrentas pasadas a su casa. Sansa, mientras tanto, recibe un regalo inesperado de Dontos Hollard. En el norte, Ygritte y Tormund se reúnen con nuevos refuerzos. En el Castillo Negro, Jon Nieve es sometido a juicio por su tiempo entre los salvajes. En su camino a Meereen, Daenerys descubre que no será bien recibida. En las Tierras de los Ríos, el Perro y Arya Stark tienen un encontronazo con soldados Lannister en una taberna.")
        
        
        let epi2S4 = Chapter(title: "The Lion and the Rose", launchingDate: formatDateAsString(dateAsString: "13-04-2014")!, episodeNumber: 2, season: season4,     director: "Alex Graves", summary: "Ramsay Nieve recibe a su padre lord Roose Bolton en Fuerte Terror. Al norte del Muro, Bran emplea sus habilidades como cambiapieles. En Rocadragón, Melisandre ordena quemar vivos en una hoguera a varios hombres de Stannis Baratheon. Desembarco del Rey celebra la boda del rey Joffrey Baratheon con Margaery Tyrell, pero Joffrey es envenenado durante esta y muere.")
        
        let epi3S4 = Chapter(title: "Breaker of Chains", launchingDate: formatDateAsString(dateAsString: "20-04-2014")!, episodeNumber: 3, season: season4, director: "Alex Graves", summary: "Tras los acontecimientos de la boda del Rey, Sansa encuentra un aliado para escapar de Desembarco del Rey. Mientras tanto, Tywin Lannister y su hija Cersei pretenden condenar a Tyrion. En el Norte, Samwell Tarly hace a Gilly mudarse a Villa Topo para mantenerla a salvo, mientras los salvajes liderados por Tormund y Styr siguen atacando aldeas. En Rocadragón, Davos Seaworth da con una idea para procurar un ejército a la causa de Stannis. En las Tierras de los Ríos, el Perro y Arya Stark continúan su viaje hacia el Valle de Arryn. A las puertas de Meereen, Daenerys y su ejército son recibidos por su campeón.")
        
        let epi4S4 = Chapter(title: "Oathkeeper", launchingDate: formatDateAsString(dateAsString: "27-04-2014")!, episodeNumber: 4, season: season4, director: "Michele MacLaren", summary: "Jaime Lannister encomienda a Brienne una misión. En el Muro, Jon Nieve reúne a un grupo de hermanos de la Guardia de la Noche para atacar a los amotinados del torreón de Craster, quienes han retenido a Bran y sus acompañantes. En Meereen, Daenerys inicia su ofensiva. Más allá del muro, Karl Tanner que lidera a los amotinados del torreón, ordena a Rast que abandone a un bebé varón en el bosque por sugerencia de las esposas de Craster, donde luego un caminante blanco se lo lleva a un altar y el Rey de la Noche lo transforma.")
        
        
        // Creamos los tres primeros de la temporada 5
        let epi1S5 = Chapter(title: "The Wars to Come", launchingDate: formatDateAsString(dateAsString: "12-04-2015")!, episodeNumber: 1, season: season5, director: "Michael Sovis", summary: "En un flashback se muestra a Cersei de niña preguntándole a una adivina por su futuro. En Desembarco del Rey Cersei critica a Jaime por liberar a Tyrion y provocar indirectamente la muerte de su padre. Mientras, en Pentos, Varys lleva a salvo a Tyrion y le revela su trabajo secreto junto con Illyrio Mopatis para llevar a Daenerys al trono de hierro. Varys invita a Tyrion a unirse a su lucha y él acepta. En Meereen, los Hijos de la Arpía, un grupo de resistencia, asesina a uno de los Inmaculados. Danaerys es informada que la misión en Yunkai ha sido exitosa, los amos han entregado el control a un consejo conformado por esclavos, pero a cambio piden la reapertura de las arenas de combate. Más tarde visita a sus dragones Viserion y Rhaegal pero ellos parecen desconocerla y la intentan atacar. En el Valle, Brienne le informa a Podrick que no lo requiere más, dado que su misión de buscar a las hermanas Stark ha fallado, por otro lado, Sansa y Baelish ven como entrena Robyn Arryn antes de marcharse a un lugar en el que Baelish asegura los Lannister no los encontrarán. Stannis le pide a Jon convencer a Mance Rayder de arrodillarse ante el rey y entregar su ejército de salvajes para atacar Invernalia que está ocupada por Roose Bolton y a su vez les daría ciudadanía y tierras para vivir, sin embargo, Mance rechaza la oferta y es mandado a morir en la hoguera. Jon, incapaz de ver como Rayder sufre con las llamas decide darle una muerte rápida clavándole una flecha en el pecho.")
        
        let epi2S5 = Chapter(title: "The House of Black and White", launchingDate: formatDateAsString(dateAsString: "19-04-2015")!, episodeNumber: 2, season: season5, director: "Michael Solvis", summary:  "En Desembarco del Rey, Cersei recibe una estatua con el collar de su hija Myrcella y Jaime se dispone a ir por ella a Dorne, pidiendo la ayuda de Bronn. En el muro, Stannis le pide a Jon que se arrodille ante él y le jure lealtad; a cambio será reconocido como Jon Stark y se le otorgará Invernalia, sin embargo él rechaza la oferta, mientras tanto los hermanos de la Guardia de la Noche eligen al próximo Lord Comandante. En el Valle, Brienne y Podrick encuentran a Sansa con Petyr; tras la negación de Sansa por obtener la protección de Brienne, ella se dispone a seguir su caravana. En Braavos, Arya llega a la Casa de Negro y Blanco, pero se le niega la entrada y más tarde encuentra a Jaqen H'ghar. En Dorne, Ellaria le pide a Doran vengarse de la muerte de su hermano Oberyn torturando a Myrcella, pero él termina negándose a tal solicitud. Tyrion y Varys comienzan su viaje a Volantis. En Meereen, Daario y los Inmaculados encuentran un miembro de los Hijos de la Arpía, sin embargo, Mossador lo asesina antes de recibir su juicio, por tal motivo Daenerys ordena su ejecución pública, lo que genera un motín entre los amos y los esclavos liberados. Por la noche, Daenerys descubre que Drogon regresó a Meereen pero se marcha antes de que ella pueda tocarlo.")
        
        let epi3S5 = Chapter(title: "High Sparrow", launchingDate: formatDateAsString(dateAsString: "26-04-2015")!, episodeNumber: 3, season: season5, director: "Michael Solvis", summary:  "En Desembarco del Rey, Tommen y Margaery contraen nupcias. Lancel ataca al Septón Supremo, éste en represión pide ejecutar al líder de los Gorriones, el Gorrión Supremo, pero tras una corta reunión personal, Cersei decide no hacerlo. Más tarde, Cersei pide a Qyburn mandarle una carta a Petyr. En el norte, Roose le comenta a Ramsay la necesidad de fortalecer su ejército y le pide que se case. Petyr le comenta a Sansa que consiguió una boda con Ramsay, pero tras su negación por tratarse de la familia que traicionó a los Stark logra convencerla afirmándole que es la oportunidad de vengarse de ellos. Petyr reitera su alianza con Roose, quien tiene dudas al saber que le llega una carta de Cersei. En Braavos, Arya deja atrás todas sus pertenencias, para convertirse en nadie. En Volantis, Jorah secuestra a Tyrion afirmando que lo llevará con la reina.")

        
        // Creamos los tres primeros de la temporada 6
        let epi1S6 = Chapter(title: "The Red Woman", launchingDate: formatDateAsString(dateAsString: "24-04-2016")!, episodeNumber: 1, season: season6, director: "Jeremy Podeswa", summary:  "El futuro de Jon nieve pende de un hilo en el Muro tras el violento ataque de los amotinados; Melissandre tiene que tomar una decisión complicada. Daenerys continúa su huida después de abandonar las tierras de Meereen donde le llevan ante el nuevo Khal. En Braavos, Arya hace frente a su difícil situación e intenta sobrevivir. Tyrion se las arregla como puede en Meereen tras la marcha de sus compañeros que van en busca de Daenerys. Mientras tanto, Jaime consigue traer de vuelta a Myrcella a Desembarco del Rey.")
        
        let epi2S6 = Chapter(title: "Home", launchingDate: formatDateAsString(dateAsString: "01-05-2016")!, episodeNumber: 2, season: season6, director: "Jeremy Podeswa", summary: "Más allá del Muro, Bran comienza su entrenamiento con el Cuervo de Tres Ojos, mientras que un joven Tommen es aconsejado por Jaime en Desembarco del Rey. Ramsay sigue con su peculiar modus operandi en el Norte y propone un plan tras la huida de Sansa y Theon. Éste último vuelve con su hermana Yara, en quien recae ahora el destino de los Greyjoy en Pyke.")
        
        let epi3S6 = Chapter(title: "Oathbreaker", launchingDate: formatDateAsString(dateAsString: "08-05-2016")!, episodeNumber: 3, season: season6, director: "Dan Sackheim", summary: "En Vaes Dothrak, Daenerys decide reunirse con las mujeres del Khal. Por su parte, Varys se ve inmerso en la búsqueda de información acerca de los Hijos de la Arpía. Mientras tanto, en Braavos, Arya continúa su entrenamiento con la Niña Abandonada para convertirse en nadie. En Desembarco del Rey, el rey Tommen se enfrenta al Gorrión Supremo acerca de su madre Cersei. Durante el transcurso de estos acontecimientos, un revivido Jon Snow intenta adaptarse a su vuelta en el Castillo Negro.")
        
        
        // Creamos los tres primeros de la temporada 7
        let epi1S7 = Chapter(title: "Dragonstone", launchingDate: formatDateAsString(dateAsString: "16-07-2017")!, episodeNumber: 1, season: season7, director: "Jeremy Podeswa", summary: "En Los Gemelos, Arya Stark envenena a los Frey restantes implicados en la Boda Roja. En Desembarco del Rey, Cersei Lannister y Jaime Lannister tratan con Euron Greyjoy intentando hacer una alianza. En Invernalia, Jon Nieve perdona a los Karstark y a los Umber haciendo que le juren lealtad, y Sansa Stark advierte a Jon de la inminente ira de Cersei. En Antigua, Samwell Tarly comienza su entrenamiento, y un enfermo Jorah Mormont le pregunta por la llegada de Daenerys. Bran Stark llega al Muro y es recibido por Edd el Penas. Sandor Clegane con la Hermandad sin Estandartes se refugia en la casa de un granjero. En Rocadragón, Daenerys Targaryen y Tyrion Lannister junto con su ejército llegan a Rocadragón y exploran el castillo abandonado que fue antes habitado por Stannis Baratheon.")
        
        let epi2S7 = Chapter(title: "Stormborn", launchingDate: formatDateAsString(dateAsString: "23-07-2017")!, episodeNumber: 2, season: season7, director: "Mark Mylod", summary: "Daenerys comienza a pensar estrategias junto a sus aliados. Melisandre llega a Rocadragón y pide a Daenerys que convoque a el Rey del Norte Jon Nieve. Sam intenta curar de psoriagrís a Jorah. Cersei entabla alianzas con los Tarly. Jon Nieve decide acudir a la llamada de Daenerys dejando Invernalia en manos de Sansa. Arya decide cambiar su rumbo hacia Invernalia, reencontrándose con su viejo amigo Pastel Caliente y su loba huargo Nymeria. Euron ataca la flota de su sobrina Yara.")
        
        let epi3S7 = Chapter(title: "The Quenn's Justice", launchingDate: formatDateAsString(dateAsString: "30-07-2017")!, episodeNumber: 3, season: season7, director: "Mark Mylod", summary: "Jon Nieve conoce a Daenerys en Rocadragón. Euron entra triunfal en Desembarco del Rey y entrega a las rehenes Ellaria y Tyene Arena ante Cersei. Jorah es curado de psoriagrís. Cersei se cobra su venganza por la muerte de Myrcella. Los Inmaculados atacan Roca Casterly, aunque las fuerzas de los Lannister han abandonado en su mayoría el castillo para capturar Altojardín, que lleva a la muerte de Olenna Tyrell, no sin antes confesar ante Jaime que mató a Joffrey.")


        
        //Añadimos episodios a cada temporada
        season1.add(episode: epi1S1)
        season1.add(episode: epi2S1)
        season1.add(episode: epi3S1)
        season1.add(episode: epi10S1)
       
        
        season2.add(episode: epi1S2)
        season2.add(episode: epi2S2)
        season2.add(episode: epi3S2)
        
        season3.add(episode: epi1S3)
        season3.add(episode: epi2S3)
        season3.add(episode: epi3S3)
        
        season4.add(episode: epi1S4)
        season4.add(episode: epi2S4)
        season4.add(episode: epi3S4)
        season4.add(episode: epi4S4)
        
        season5.add(episode: epi1S5)
        season5.add(episode: epi2S5)
        season5.add(episode: epi3S5)
        
        season6.add(episode: epi1S6)
        season6.add(episode: epi2S6)
        season6.add(episode: epi3S6)
        
        season7.add(episode: epi1S7)
        season7.add(episode: epi2S7)
        season7.add(episode: epi3S7)
    
        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
        
    }
    
    
    
    // Funciones House
    func house(named name: String) -> House? {
        return houses.first { $0.name.uppercased() == name.uppercased() } // filter + first
    }
    
   /* enum casas:String {
        case Stark, Lannister, Targaryen
    }
    
    
    // MARK: - FUNCIÓN DEL EJERCICIO 8
    func houseEJ8(named casa: casas) -> House? {
        print(casa)
        return houses.first {$0.name == "Stark"}
//        return houses.first {$0.name == casa.rawValue}
        
        
    }
*/
    
    
    
  // MARK: - FUNCIÓN DEL EJERCICIO 8
  

    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter) 
    }
    
    
    func formatDateAsString(dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return (dateFormatter.date(from: dateAsString))
    }
    
    // Funciones Season
    func season(named name: String) -> Season? {
        return seasons.first {$0.name.uppercased() == name.uppercased()}
    }
    
   func seasons(filteredBy theFilter: (Season) -> Bool) -> [Season] {
        return seasons.filter(theFilter)
    }
    
}


