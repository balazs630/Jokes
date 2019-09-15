-- Database changes for app version: 1.4

-- Delete duplicate jokes
DELETE FROM jokes WHERE jokeId = CASE
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 162 OR jokeId = 195 AND isUsed = 0) = 2 THEN 195
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 162 OR jokeId = 195 AND isUsed = 1) = 2 THEN 195
    WHEN jokeId = 162 OR jokeId = 195 AND isUsed = 0 THEN jokeId
END;

DELETE FROM jokes WHERE jokeId = CASE
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 147 OR jokeId = 270 AND isUsed = 0) = 2 THEN 270
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 147 OR jokeId = 270 AND isUsed = 1) = 2 THEN 270
    WHEN jokeId = 147 OR jokeId = 270 AND isUsed = 0 THEN jokeId
END;

-- Add more jokes to the collection
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi lesz a műfogsorból ha alámegy a pirospaprika?\n- ???\n- Csípőprotézis.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Most nem szabad a kávéfőzőnek titkokat elárulni?\n- ???\n- Mert kikotyogja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi lesz a túróból akit bolti lopáson kapnak?\n- ???\n- Körözött.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mi van Monica Belucci hangpostáján?\n- ???\n- A szám jelenleg foglalt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi a baj fiacskám?\n- Jaj, az anyám beleesett a pöcegödörbe!\n- Te jó ég! - kiált fel a férfi majd elszántan a pöcegödörbe ugrik segíteni:\n- Fiam, sehol se találom az anyádat!\n A gyerek belenyúl a zsebébe, kiemel egy csavart és bedobja a gödörbe:\n- Akkor a csavar se kell!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Versenyt repül a gém meg a gólya. Egy vadász észreveszi őket, előkapja a puskáját, lő. A gém élettelenól lezuhan. A gólya utánanéz:\n- Gém over...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Régen ismeri már ezt a pszichiátert?\n- Meglehetősen régen.\n- Maga is mániás depresszióval jár hozzá?\n- Nem. Én autóbusszal...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi az: se keze se lába, és mégis minden este borozik a kocsmában?\n- ???\n- Törzsvendég.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mivel lehet leküzdeni a farkaséhséget?\n- ???\n- Piroskával.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mondja hölgyem, a maga férje nem beszél amikor egyedül van?\n- Nem tudom. Még nem voltunk soha együtt amikor egyedül volt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Mit mond a szénégető, miután elhasal a hamuban?\n- ???\n- Hogy lehettem ilyen faszén...! ');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka bemegy a pékségbe és kér egy kiflit. Olyan kemény mint a kő.\n- Mai nincs?\n- De... Holnap lesz!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Mi szeretett volna lenni Móricka kiskorában?\n- Először asztal akart lenni, de széklet. Aztán meg komp akart lenni, de nem komplett.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka, menj el szépen a henteshez és hozzál tőle hurkát.\n- Hurkáááát?\n- Igen, fiacskám, jól jegyezd meg: hurkát. De ne véreset.\n- Denevéreseeet?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Milyen időben vannak ezek az igék: én fázom, te fázol, ő fázik.\nMóricka válaszol:\n- Hideg időben tanárnő...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Miért sírsz Móricka?\n- Mert a papám ráütött az ujjára kalapáccsal.\n- De hát ezért nem neked kéne sírnod!\n- Tudom, először én is röhögtem.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Moricka, mondjál egy szót amiben két R betű van!\n- Tojás!\n- Na de Móricka, hol vannak az R betűk?\n- Egy a fehéRjében, másik a sáRgájában!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Bocsánat uram, nem találkoztunk mi tavaly nyáron Pesten?\n- Nem, nem jártam ott tavaly.\n-Én sem. Akkor biztosan két másik ember volt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Két szú beszélget:\n- Mondja kolléga, miért nem jön át ebbe a remek bükkbe?\n- Mert a feleségem cserbenhagyott.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Bemegy a patkány az elektronikai szaküzletbe.\n- Kérek egy tévét.\n- Színeset vagy fekete-fehéret?\n- Mindegy, csak sok csatorna legyen benne!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mit énekelnek a molyok a szekrényben?\n- ???\n- Edda-búzt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Melyik az az állat, amelyiknek több mint a fele zsír?\n- ???\n- A zsiráf.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Melyik a legsavanyúbb madár?\n- ???\n- A citromhéja!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Miért szeretne a rókalány lövészversenyre menni?\n- ???\n- Mert ott mindig meghúzzák a ravaszt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mi villan át a légy agyán, amikor nekivágódik a szélvédőnek?\n- ???\n- A hátsója...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Miért nincs a méhecskének 45-ös lába?\n- ???\n- Mert letaposná a  virágokat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Hogy hívják a jóllakott szúnyogot?\n- ???\n- Telivér.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mit tettek az ősmagyarok a nyereg alá?\n- ???\n- Lovat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Mondja Jean, szőrös a csengő?\n- Nem uram.\n- Akkor az éjjel megint a házmesternét nyomtam meg.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Itt vannak a fagyosszentek, uram.\n- Jól van Jean, akkor engedje be őket!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, vegyen elő egy ruhaakasztót a szekrényből, kirándulni megyünk.\n- És minek ahhoz ruhaakasztó, uram?\n- Hogy fogassal menjünk a Szabadság-hegyre.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mi az ott a fa tetején?\n- ???\n- A fészkes fene, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mondja mi után kutat a kamrában?\n- ???\n- Kenyérkereső vagyok, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mi ez a trappolás az udvaron?\n- ???\n- Edzenek a futórózsák, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mik ezek a kék foltok a testén?\n- ???\n- Cseberből vederbe estem, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Mivel locsoljam meg a virágokat, uram?\n- ???\n- Mivel szárazak, Jean...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Morickáék nyaralnak a vízparton: Anyu, én meghaltam?\n- Miért kérdezel ilyen hülyeséget kisfiam?\n- Ott jön a hullám...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, tegye be az ajtót!\n- Hova uram?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy hívják a sivatagi anyóst?\n- ???\n- Tevén banya.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A munkakerülő dolgozók ugratják egymást:\n- Te is olyan vagy, mint a toronyóra reggel...\n- Miért?\n- Az is elütötte már a hetet...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Ki az abszolút udvarias?\n- ???\n- Aki átadja a helyét a fáradt olajnak.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mit kiált a gyümölcsösgazda a tolvajok után?\n- ???\n- Elverlek, mint jégeső a zsenge termést!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi az optimista ember kedvenc szövege?\n- ???\n- Holnap lesz hátralévő életed első napja!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Mit mond Gazsi ha lát egy szép nőt az utcán?\n- ???\n- Dugnám, mint a lopott biciklit!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi a plátói szerelem?\n- ???\n- Kívülről nyalogatni a lekváros üveget.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mit mond a lenyűgözött ember?\n- ???\n- Elkápráztattál, mint vak macskát az autóreflektor.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','Mit kiáltanak a szőke nő után a forgalomban?\n- ???\n- Te is inkább áramot vezessél, ne autót!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mit mond az idős néni miután lefejelte a villanyoszlopot?\n- ???\n- Meg vagyok zavarodva, mint vasorrú bába a mágneses viharban.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Doktor úr, kérem vizsgálja meg a feleségem, mert nagyon gyerekes a viselkedése.\n- Miben nyilvánul ez meg?\n- Abban hogy valahányszor fürdök, bejön a fürdőszobába és sorra elsüllyeszti a papírhajóimat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Hogy hívják a cigányt öltönyben és nyakkendőben?\n- ???\n- Vádlott, álljon fel...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Elfogja a rendőr a cigányt.\n- Te Gazsi, hol loptad ezt a lovat?\n- Nem loptam én, nyertem sakkban!\n- De hiszen te nem is tudsz sakkozni!\n- Már miért ne tudnék? Leütöttem a parasztot, és léptem a lóval.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Te, Gazsi! Hun születtél?\n- Hát, a kórházban.\n- Mér, beteg vótá...?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Két cigány gyalogol az úton. Egy kereszteződéshez érve meglátnak egy feszületet. Egyikük odafordul:\n- Dícsértessék!\nA társa megkérdezi:\n- Mi az more, ismered?\n-Há'mán hogyne! Hiszen ő adja mindennapi kenyerünket.\nMire a másik:\n- Mé, pék a csávó?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két zenész beszélget:\n- Képzeld, múlt héten betörtek hozzám. Elvitték a tévét, videót, a hegedűmet...\n- És mekkora a károd?\n- Hát olyan tizenhét centi...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Gazsi és az asszony letelepednek a folyóparton, s napozás közben Gazsi elalszik. Arra ébred, hogy az asszony rázza a vállát:\n- Te Gazsi, gyerünk a hűvösre!\nMire Gazsi félálomban:\n- De hát én nem csináltam most semmit!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit szólsz, hogy ez a szegény Gazsi megvakult?\n- Ne mond már, hiszen este még látott a kocsmában.\n- Igen, de ott letarháltam egy ezressel, és azt már sose látja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','');
