import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/hym.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';

class AllHyms {
  List<String> allHyms = [
    '''1  Praise to the Lord+
1\n
Praise to the Lord, the Almighty, the King of creation!
O my soul, praise Him, for He is thy health and salvation!
All ye who hear, now to His temple draw near;
Join ye in glad adoration!~
2\n
Praise to the Lord, Who o'er all things so wondrously reigneth,
Shieldeth thee under His wings, yea, so gently sustaineth!
Hast thou not seen how thy desires e'er have been
Granted in what He ordaineth?~
3\n
Praise to the Lord, who doth prosper thy work and defend thee;
Surely His goodness and mercy here daily attend thee. Ponder anew what the Almighty can do,If with His love He befriend thee.''',
    '''2  All creatures of our God and King+
1\n
All creatures of our God and King,
Lift up your voice with us and sing:
Alleluia! Alleluia!
O burning sun with golden beam
And silver moon with softer gleam:~
Refrain\n
Oh, praise Him! Oh, praise Him!
Alleluia, alleluia, alleluia!~
2\n
O rushing wind and breezes soft,
O clouds that ride the winds aloft:
Oh, praise Him! Alleluia!
O rising morn, in praise rejoice,
O lights of evening, find a voice.~
3\n
0 flowing waters, pure and clear,
Make music for your Lord to hear.
Oh praise Him! Alleluia!
O fire so masterful and bright,
Providing us with warmth and light.~
4\n
Let all things their Creator bless,
And worship him in humbleness,
O praise him Alleluia!
Oh, praise the Father, praise the Son, 
And praise the Spirit, three in One!''',
    '''4  Praise, My Soul, the King of Heaven+
1\n
Praise, my soul, the King of heaven;
To His feet thy tribute bring.
Ransomed, healed, restored, forgiven,
Who like thee His praise should sing?
Praise Him, praise Him, Alleluia,
Praise the everlasting King.~
2\n
Praise Him for His grace and favor
To our fathers in distress.
Praise Him, still the same forever,
Slow to chide and swift to bless;
Praise Him, praise Him, Alleluia,
Glorious in His faithfulness.~
3\n
Tenderly He shields and spares us;
Well our feeble frame He knows.
In His hands He gently bears us,
Rescues us from all our foes.
Praise Him, praise Him, Alleluia,
Widely as His mercy flows. ~
4\n
Angels, help us to adore Him:
Ye behold Him face to face;
Sun and moon, bow down before Him:
Dwellers all in time and space.
Praise Him, praise Him, Alleluia,
Praise with us the God of grace.''',
    '''6  O Worship the Lord+
1\n
O worship the Lord in the beauty of holiness,
Bow down before Him, His glory proclaim;
With gold of obedience, and incense of lowliness,
Kneel and adore Him: the Lord is His name.~
2\n
Low at His feet lay thy burden of carefulness,
High on His heart He will bear it for thee,
Comfort thy sorrows, and answer thy prayerfulness,
Guiding thy steps as may best for thee be.~
3\n
Fear not to enter His courts in the slenderness
Of the poor wealth thou wouldst reckon as thine;
Truth in its beauty, and love in its tenderness, 
These are the offerings to lay on His shrine.~
4\n
These, though we bring them in trembling and fearfulness,
He will accept for the name that is dear;
Mornings of joy give for evenings of tearfulness,
Trust for our trembling, and hope for our fear.''',
    '''7  The Lord in Zion Reigneth+
1\n
The Lord in Zion reigneth, let all the world rejoice,
And come before His throne of grace with tuneful heart and
voice;
The Lord in Zion reigneth, and there His praise shall ring,
To Him shall princes bend the knee and kings their glory bring.~
2\n
The Lord in Zion reigneth, and who so great as He?
The depths of earth are in His hands; He rules the mighty sea.
O crown His Name with honor, and let His standard wave,
Till distant isles beyond the deep shall own His power to save.~
3\n
The Lord in Zion reigneth, these hours to Him belong;
O enter now His temple gates, and fill His courts with song;
Beneath His royal banner let every creature fall,
Exalt the King of heaven and earth, and crown Him Lord of all. ''',
    '''8  We Gather Together+
1\n
We gather together to ask the Lord's blessing;
He chastens and hastens His will to make known.
The wicked oppressing now cease from distressing.
Sing praises to His Name; He forgets not His own.~
2\n
Beside us to guide us, our God with us joining,
Ordaining, maintaining His kingdom divine;
So from the beginning the fight we were winning;
Thou, Lord, were at our side, all glory be Thine!~
3\n
We all do extol Thee, Thou leader triumphant,
And pray that Thou still our defender wilt be.
Let Thy congregation escape tribulation;
Thy name be ever praised! O Lord, make us free! ''',
    '''11  The God of Abraham Praise+
1\n
The God of Abraham praise,
Who reigns enthroned above;
Ancient of everlasting days,
And God of love;
Jehovah! Great I AM!
By earth and heaven confessed;
I bow and bless the sacred name,
Forever blest.~
2\n
The God of Abraham praise,
At whose supreme command
From earth I rise, and seek the joys
At His right hand;
I all on earth forsake,
Its wisdom, fame and power;
And Him my only portion make,
My shield and tower.~
3\n
The whole triumphant host
Give thanks to God on high;
"Hail, Father, Son, and Holy Ghost!"
They ever cry;
Hail, Abraham's God and mine! 
I join the heavenly lays;
All might and majesty are Thine,
And endless praise.''',
    '''12  Joyful, Joyful, We Adore Thee+
1\n
Joyful, joyful, we adore Thee,
God of glory, Lord of love;
Hearts unfold like flow'rs before Thee,
Hail Thee as the sun above.
Melt the clouds of sin and sadness,
Drive the dark of doubt away;
Giver of immortal gladness,
Fill us with the light of day!~
2\n
All Thy works with joy surround Thee,
Earth and heav'n reflect Thy rays,
Stars and angels sing around Thee,
Center of unbroken praise;
Field and forest, vale and mountain,
Bloss'ming meadow, flashing sea,
Chanting bird and flowing fountain
Call us to rejoice in Thee. ~
3\n
Thou art giving and forgiving,
Ever blessing, ever blest,
Wellspring of the joy of living,
Oceandepth of happy rest!
Thou the father, Christ our Brother -
All who live in love are Thine:
Teach us how to love each other,
Lift us to the joy divine.''',
    '''15  My Maker and My King+
1\n
My Maker and my King,
To Thee my all I owe;
Thy sovereign bounty is the spring
Whence all my blessings flow;
Thy sovereign bounty is the spring
Whence all my blessings flow.~
2\n
The creature of Thy hand,
On Thee alone I live;
My God, Thy benefits demand 
More praise than I can give.
My God, Thy benefits demand
More praise than I can give.~
3\n
Lord, what can I impart
When all is Thine before?
Thy love demands a thankful heart;
The gift, alas! how poor.
Thy love demands a thankful heart;
The gift, alas! how poor.~
4\n
O! let Thy grace inspire
My soul with strength divine;
Let every word each desire
And all my days be Thine.
Let every word each desire
And all my days be Thine.''',
    '''16  All People That on Earth Do Well+
1\n
All people that on earth do dwell,
sing to the Lord with cheerful voice.
Him serve with mirth, his praise forth tell;
come ye before him and rejoice. ~
2\n
Know that the Lord is God indeed;
without our aid he did us make;
we are his folk, he doth us feed,
and for his sheep he doth us take.~
3\n
O enter then his gates with praise;
approach with joy his courts unto;
praise, laud, and bless his name always,
for it is seemly so to do.~
4\n
For why! the Lord our God is good;
his mercy is forever sure;
his truth at all times firmly stood,
and shall from age to age endure.''',
    '''19  O Sing a New Song to the Lord+
1\n
O sing a new song to the Lord
For marvels He has done;
His right hand and His holy arm
The victory have won.~
2\n
With harp, and voice of psalms
Unto Jehovah sing;
Let trumpets and the echoing horn
Acclaim the Lord our King!~
3\n
Let seas with all their creatures roar,
The world and dwellers there,
And let the rivers clap their hands,
The hills their joy declare.~
4\n
Before the Lord: because He comes,
To judge the earth come He;
He'll judge the world
with righteousness,
His folk with equity.''',
    '''20  O Praise Ye the Lord+
1\n
O praise ye the Lord!
Praise Him in the height;
Rejoice in His word,
Ye angels of light;
Ye heavens, adore Him
By whom ye were made,
And worship before Him,
In brightness arrayed. ~
2\n
O praise ye the Lord!
Praise Him upon earth,
In tuneful accord:
Ye sons of new birth;
Praise Him who hath brought
you His grace from above,
Praise Him who hath taught
you To sing of His love.~
3\n
O praise ye the Lord,
All things that give sound;
Each jubilant chord,
Re-echo around;
Loud organs His glory
Forth tell in deep tone,
And sweet harp, the story
Of what He hath done.~
4\n
O praise ye the Lord!
Thanksgiving and song
To Him be outpoured
All ages along:
For love in creation,
For heaven restored.
For grace of salvation, 
O praise ye the Lord!''',
    '''21  Immortal, Invisible, God Only Wise+
1\n
Immortal, invisible, God only wise,
In light inaccessible hid from our eyes,
Most blessed, most glorious, the Ancient of Days,
Almighty, victorious, Thy great Name we praise.~
2\n
Unresting, unhasting, and silent as light,
Nor wanting, nor wasting, Thou rulest in might;
Thy justice, like mountains, high soaring above
Thy clouds, which are fountains of goodness and love.~
3\n
To all, life Thou givest, to both great and small;
In all life Thou livest, the true life of all;
We blossom and flourish as leaves on the tree,
And wither and perish - but naught changeth Thee.~
4\n
Great Father of glory, pure Father of light, 
Thine angels adore Thee, all veiling their sight;
All praise we would render; O help us to see
'Tis only the splendor of light hideth Thee!''',
    '''25  Praise the Lord, His Glories Show+
1\n
Praise the Lord, His glories show, Alleluia!
Saints within His courts below, Alleluia!
Angels 'round His throne above, Alleluia!
All that see and share His love, Alleluia!~
2\n
Earth to heaven and heaven to earth, Alleluia!
Tell His wonders, sing His worth, Alleluia!
Age to age and shore to shore, Alleluia!
Praise Him, praise Him evermore! Alleluia!~
3\n
Praise the Lord, His mercies trace, Alleluia!
Praise His providence and grace, Alleluia!
All that He for man hath done, Alleluia!
All He sends us through His Son. Alleluia! ''',
    '''26  Praise the Lord! You Heavens Adore Him+
1\n
Praise the Lord: you heavens, adore Him;
Praise Him, angels in the height;
Sun and moon, rejoice before Him;
praise Him, all you stars of light.
Praise the Lord, for He has spoken;
worlds His mighty voice obeyed.
Laws which never shall be broken
for their guidance He has made.~
2\n
Praise the Lord! for He is glorious;
never shall His promise fail.
God has made His saints victorious;
sin and death shall not prevail.
Praise the God of our salvation!
hosts on high, His power proclaim.
Heaven and earth and all creation,
laud and magnify His Name.~
3\n
Worship, honor, glory, blessing,
Lord, we offer as our gift.
Young and old, Your praise expressing,
Our glad songs to You we lift.
All the saints in heaven adore You; 
we would join their glad acclaim;
As Your angels serve before You,
so on earth we praise Your name.''',
    '''27  Rejoice, Ye Pure in Heart!+
1\n
Rejoice ye pure in heart!
Rejoice, give thanks, and sing;
Your festal banner wave on high,
The cross of Christ your King.~
Refrain\n
Rejoice, rejoice, rejoice,
Give thanks and sing.~
2\n
With voice as full and strong
As ocean's surging praise,
Send forth the sturdy hymns of old,
The psalms of ancient days.~
3\n
With all the angel choirs,
With all the saints of earth, 
Pour out the strains of joy and bliss,
True rapture, noblest mirth.~
4\n
Yes, on through life's long path,
Still chanting as ye go;
From youth to age, by night and day,
In gladness and in woe.~
5\n
Praise Him who reigns on high,
The Lord whom we adore,
The Father, Son and Holy Ghost,
One God forever more.
(Refrain)''',
    '''29  Sing Praise to God+
1\n
Sing praise to God who reigns above,
the God of all creation,
the God of power, the God of love,
the God of our salvation.
With healing balm my soul He fills,
and every faithless murmur stills;
To God all praise and glory!~
2\n
What God's almighty power hath made 
His gracious mercy keepeth;
By morning glow or evening shade,
His watchful eye ne'er sleepeth,
Within the kingdom of his might,
Lo! all is just, and all is right:
To God all praise and glory!~
3\n
The Lord is never far away,
throughout all grief distressing,
an ever present help and stay,
our peace and joy and blessing.
As with a mother's tender hand,
He leads His own, His chosen band:
To God all praise and glory!~
4\n
Then all my gladsome way along,
I sing aloud thy praises,
that men may hear the grateful song
my voice unwearied raises:
Be joyful in the Lord, my heart!
both soul and body bear your part!
To God all praise and glory.''',
    '''34  Wake the Song+
1\n
Wake the song of joy and gladness;
Hither bring your noblest lays;
Bannish every thought of sadness,
Pouring forth your highest praise.
Sing to Him whose care has brought us
Once again with friends to meet,
And whose loving voice has taught us
Of the way to Jesus' feet.~
Refrain\n
Wake the song, wake the song,
The song of joy and gladness,
Wake the song, wake the song,
The song of Jubilee.~
2\n
Joyfully with songs and banners,
We will greet the festal day;
Shout aloud our glad hosannas,
And our grateful homage pay.
We will chant our Savior's glory
while our thoughts we raise above,
Telling still the old, old, story,
Precious theme- redeeming love!~
3\n
Thanks to Thee, O holy Father, 
For the mercies of the year;
May each heart, as here we gather,
Swell with gratitude sincere,
Thanks to Thee, O loving Savior,
For redemption through Thy blood.
Breathe upon us, Holy Spirit,
Sweetly draw us near to God.''',
    '''39  Lord, in the Morning+
1\n
Lord, in the morning Thou shalt hear
My voice ascending high;
To Thee will I direct my prayer,
To Thee lift up mine eye~
2\n
Up to the hills where Christ is gone
To plead for all His saints,
Presenting at His Father's throne
Our songs and our complaints.~
3\n
O may Thy Spirit guide my feet
In ways of righteousness;
Make every path of duty straight 
And plain before my face.~
4\n
The men that love and fear Thy name
Shall see their hopes fulfilled;
The mighty God will compass them
With favor as a shield.''',
    '''43  When Morning Gilds the Skies+
1\n
When morning gilds the skies my heart awaking cries,
May Jesus Christ be praised!
Alike at work and prayer, to Jesus I repair:
May Jesus Christ be praised!~
2\n
Whene'er the sweet church bell peals over hill and dell,
May Jesus Christ praised!
O hark to what it sings, as joyously it rings,
May Jesus Christ be praised!~
3\n
The night becomes as day when from the heart we say:
May Jesus Christ be praised!
The powers of darkness fear when this sweet chant they hear:
May Jesus Christ be praised! ~
4\n
Ye nations of mankind, in this your concord find,
May Jesus Christ praised!
Let all the earth around ring joyous with the sound,
May Jesus Christ praised!~
5\n
In heaven's eternal bliss the loveliest strain is this,
May Jesus Christ praised!
Let earth, and sea and sky from depth to height reply,
May Jesus Christ praised!~
6\n
Be this, while life is mine, my canticle divine:
May Jesus Christ be praised!
Be this th'eternal song through all the ages long,
May Jesus Christ be praised!''',
    '''48  Softly Now the Light of Day+
1\n
Softly now the light of day
Fades upon out sight away:
Free from care, from labor free,
Lord, we would commune with Thee. ~
2\n
Thou, whose allpervading eye
Nought escapes, without, within,
Pardon each infirmity,
Open fault, and secret sin.~
3\n
Soon from us the light of day
Shall forever pass away;
Then, from sin and sorrow free,
Take us, Lord, to dwell with Thee.''',
    '''50  Abide With Me+
1\n
Abide with me; fast falls the eventide;
The darkness deepens; Lord with me abide!
When other helpers fail and comforts flee,
Help of the helpless, O abide with me.~
2\n
Swift to its close ebbs out life's little day;
Earth's joys grow dim; its glories pass away;
Change and decay in all around I see; 
O Thou who changest not, abide with me.~
3\n
I need Thy presence every passing hour.
What but Thy grace can foil the tempter's power?
Who, like Thyself, my guide and stay can be?
Through cloud and sunshine, Lord, abide with me.~
4\n
I fear no foe, with Thee at hand to bless;
Ills have no weight, and tears no bitterness.
Where is death's sting? Where, grave, thy victory?
I triumph still, if Thou abide with me!''',
    '''51  Day Is Dying in the West+
1\n
Day is dying in the west;
Heaven is touching earth with rest;
Wait and worship while the night
Sets the evening lamps alight
Through all the sky.~
Refrain\n
Holy, holy, holy, Lord God of Hosts!
Heaven and earth are full of Thee!
Heaven and earth are praising Thee,
O Lord most high! ~
2\n
Lord of life, beneath the dome
Of the universe, Thy home,
Gather us who seek Thy face
To the fold of Thy embrace,
For Thou art nigh.~
3\n
While the deepening shadows fall,
Heart of love enfolding all,
Through the glory and the grace
Of the stars that veil Thy face,
Our hearts ascend.~
4\n
When forever from our sight
Pass the stars, the day, the night,
Lord of angels, on our eyes
Let eternal morning rise
And shadows end.''',
    '''53  All Praise to Thee+
1\n
All praise to thee, my God, this night,
for all the blessings of the light!
Keep me, O keep me, King of kings, 
beneath thine own almighty wings.~
2\n
Forgive me, Lord, for thy dear Son,
the ill that I this day have done,
that with the world, myself, and thee,
I, ere I sleep, at peace may be.~
3\n
O may my soul on thee repose,
and with sweet sleep mine eyelids close,
sleep that may me more vigorous make
to serve my God when I awake.~
4\n
Praise God, from whom all blessings flow;
praise him, all creatures here below;
praise him above, ye heavenly host;
praise Father, Son, and Holy Ghost.''',
    '''56  The Day Thou Gavest+
1\n
The day Thou gavest, Lord, is ended;
the darkness falls at Thy behest;
to Thee our morning hymns ascended;
Thy praise shall hallow now our rest.~
2\n
We thank Thee that Thy church, unsleeping
while earth rolls onward into light,
through all the world her watch is keeping,
and rests not now by day or night.~
3\n
As o'er each continent and island
the dawn leads on another day,
the voice of prayer is never silent,
nor die the strains of praise away.~
4\n
So be it, Lord; Thy throne shall never,
like earth's proud empires, pass away.
Thy kingdom stands, and grows forever,
till all Thy creatures own Thy sway.''',
    '''64  Lord, Dismiss Us With Thy Blessing+
1\n
Lord, dismiss us with thy blessing;
fill our hearts with joy and peace;
let us each, thy love possessing,
triumph in redeeming grace.
O refresh us, O refresh us,
traveling through this wilderness. ~
2\n
Thanks we give and adoration
for thy gospel's joyful sound.
May the fruits of thy salvation
in our hearts and lives abound;
ever faithful, ever faithful
to the truth may we be found.''',
    '''65  God Be With You+
1\n
God be with you till we meet again;
By His counsels guide, uphold you,
With His sheep securely fold you;
God be with you till we meet again.~
Refrain\n
Till we meet, till we meet,
Till we meet at Jesus' feet;
Till we meet, till we meet,
God be with you till we meet again.~
2\n
God be with you till we meet again;
'Neath His wings securely hide you;
Daily manna still provide you;
God be with you till we meet again. ~
3\n
God be with you till we meet again;
When life's perils thick confound you;
Put His arms unfailing round you;
God be with you till we meet again.~
4\n
God be with you till we meet again;
Keep love's banner floating over you,
Strike death's threatening wave before you;
God be with you till we meet again.''',
    '''70  Praise Ye the Father+
1\n
Praise ye the Father for His loving kindness,
Tenderly cares He for His erring children;
Praise Him, ye angels, praise Him in the heavens;
Praise ye Jehovah!~
2\n
Praise ye the Savior, great is the compassion,
Graciously cares He for His chosen people;
Young men and maidens, ye old men and children,
Praise ye the Savior! ~
3\n
Praise ye the Spirit, comforter of Israel,
Sent of the Father and the Son to bless us;
Praise ye the Father, Son, and Holy Spirit,
Praise the Eternal Three!''',
    '''73  Holy, Holy, Holy+
1\n
Holy, holy, holy! Lord God Almighty!
Early in the morning our song shall rise to Thee;
Holy, holy, holy, merciful and mighty!
God in three Persons, blessed Trinity!~
2\n
Holy, holy, holy! Angels adore Thee,
Casting down their golden crowns around the glassy sea;
Thousands and ten thousands worship low before Thee,
Which wert, and art, and evermore shalt be.~
3\n
Holy, holy, holy! though the darkness hide Thee,
Though the eye of sinful man Thy glory may not see; 
Only Thou art holy; there is none beside Thee,
Perfect in power, in love, and purity.~
4\n
Holy, holy, holy! Lord God Almighty!
All Thy works shall praise Thy name, in earth, and sky, and sea;
Holy, holy, holy; merciful and mighty!
God in three Persons, blessed Trinity!''',
    '''74  Like a River Glorious+
1\n
Like a river glorious, is God's perfect peace,
Over all victorious, in its bright increase;
Perfect, yet it floweth, fuller every day,
Perfect, yet it groweth, deeper all the way.~
Refrain\n
Stayed upon Jehovah, hearts are fully blessed
Finding, as He promised, perfect peace and rest.~
2\n
Hidden in the hollow of His blessed hand,
Never foe can follow, never traitor stand;
Not a surge of worry, not a shade of care,
Not a blast of hurry touch the spirit there.~
3\n
Every joy or trial falleth from above,
Traced upon our dial by the Sun of Love;
We may trust Him fully all for us to do.
They who trust Him wholly find Him wholly true.''',
    '''76  O Love That Wilt Not Let Me Go+
1\n
O Love that wilt not let me go,
I rest my weary soul in thee;
I give thee back the life I owe,
that in thine ocean depths
its flow may richer, fuller be.~
2\n
O Light that followest all my way,
I yield my flickering torch to thee;
my heart restores its borrowed ray,
that in they sunshine's blaze
its day may brighter, fairer be.~
3\n
O Joy that seekest me through pain,
I cannot close my heart to thee;
I trace the rainbow thru the rain,
and feel the promise is not vain,
that morn shall tearless be. ~
4\n
O Cross that liftest up my head,
I dare not ask to fly from thee;
I lay in dust life's glory dead,
and from the ground there blossoms
red life that shall endless be.''',
    '''82  Before Jehova's Awful Throne+
1\n
Before Jehovah's awful throne,
Ye nations, bow with sacred joy;
Know that the Lord is God alone;
He can create, and He destroy.~
2\n
His sovereign power, without our aid,
Made us of clay, and formed us men;
and when like wandering sheep we strayed,
He brought us to His fold again.~
3\n
We'll crowd His gates with thankful songs,
High as the heavens our voices raise;
And earth, with her ten thousand tongues,
Shall fill His courts with sounding praise. ~
4\n
Wide as the world is His command,
Vast as Eternity His love;
Firm as a rock His truth shall stand,
When rolling years shall cease to move.''',
    '''83  O Worship the King+
1\n
O worship the King, all glorious above,
O gratefully sing His wonderful love;
Our Shield and Defender, the Ancient of Days,
Pavilioned in splendor, and girded with praise.~
2\n
O tell of His might, O sing of His grace,
Whose robe is the light, whose canopy space,
His chariots of wrath the deep thunderclouds form,
And dark is His path on the wings of the storm.~
\n
Thy bountiful care, what tongue can recite?
It breathes in the air, it shines in the light;
It streams from the hills, it descends to the plain,
And sweetly distills in the dew and the rain.~
4\n
Frail children of dust, and feeble as frail, 
In Thee do we trust, nor find Thee to fail;
Thy mercies how tender, how firm to the end!
Our Maker, Defender, Redeemer, and Friend.''',
    '''85  Eternal Father, Strong to Save+
1\n
Eternal Father, strong to save,
Whose arm hath bound the restless wave,
Who bid'st the mighty ocean deep
Its own appointed limits keep;
Oh hear us when we cry to Thee
For those in peril on the sea.~
2\n
O Christ, whose voice the waters heard,
And hushed their raging at Thy word,
Who walkedst on the foaming deep,
And calm amidst its rage didst sleep;
Oh, hear us when we cry to Thee
For those in peril on the sea.~
3\n
O Holy Spirit, who didst brood
Upon the waters dark and rude,
And bid their angry tumult cease,
And give, for wild confusion, peace:
Oh, hear us when we cry to Thee 
For those in peril on the sea.~
4\n
O Trinity of love and power,
All trav'lers shield in danger's hour;
From rock and tempest, fire and foe,
Protect them wheresoe'er they go;
Thus evermore shall rise to The
Glad humns of praise from land and sea.''',
    '''88  I Sing the Migthy Power of God+
1\n
I sing the almighty power of God,
that made the mountains rise,
that spread the flowing seas abroad,
and built the lofty skies.
I sing the wisdom that ordained
the sun to rule the day;
the moon shines full at God's command,
and all the stars obey.~
2\n
I sing the goodness of the Lord,
who filled the earth with food,
who formed the creatures thru the Word,
and then pronounced them good. 
Lord, how thy wonders are displayed,
where'er I turn my eye,
if I survey the ground I tread,
or gaze upon the sky!~
3\n
There's not a plant or flower below,
but makes thy glories known,
and clouds arise, and tempests blow,
by order from thy thrown;
while all that borrows life from thee
is ever in thy care;
and everywhere that we can be,
thou, God, art present there.''',
    '''92  This Is My Father's World+
1\n
This is my Father's world,
and to my listening ears
all nature sings, and round me rings
the music of the spheres.
This is my Father's world:
I rest me in the thought
of rocks and trees, of skies and seas; 
his hand the wonders wrought.~
2\n
This is my Father's world,
the birds their carols raise,
the morning light, the lily white,
declare their maker's praise.
This is my Father's world:
he shines in all that's fair;
in the rustling grass I hear him pass;
he speaks to me everywhere.~
3\n
This is my Father's world.
O let me ne'er forget
that though the wrong seems oft so strong,
God is the ruler yet.
This is my Father's world:
why should my heart be sad?
The Lord is King; let the heavens ring!
God reigns; let the earth be glad!''',
    '''93  All Things Bright and Beautiful+
1*\n
All things bright and beautiful,
All creatures great and small,
All things wise and wonderful,
The Lord made them all.~
2\n
Each little flower that opens,
Each little bird that sings;
He made their glowing colors,
He made their tiny wings.~
3\n
The purpleheaded mountain,
The river running by
The sunset, and the morning
That brightens up the sky,~
4\n
The cold wind in the winter,
The pleasant summer sun,
The ripe fruits in the garden,
He made them every one.~
5\n
He gave us eyes to see them,
And lips that we might tell
How great is God Almighty,
Who has made all things well.
 \n*Stanza 1 to be sung as refrain after stanzas 2 to 5''',
    '''96  The Spacious Firmament+
1\n
The spacious firmament on high,
With all the blue, ethereal sky,
And spangled heavens, a shining frame,
Their great Original proclaim.
Th'unwearied sun from day to day
Does his Creator's power display,
And publishes to every land
The work of an almighty hand~
2\n
Soon as the evening shades prevail,
The moon takes up the wondrous tale;
And nightly to the listening earth
Repeats the story of her birth;
While all the stars that round her burn,
And all the planets in their turn,
Confirm the tidings as they roll,
And spread the truth from pole to pole~
3\n
What though in solemn silence all
Move round the dark terrestrial ball? 
What though no real voice nor sound
Amid their radiant orbs be found?
In reason's ear they all rejoice
And utter forth a glorious voice,
Forever singing as they shine,
"The hand that made us is divine." ''',
    '''99  God Will Take Care of You+
1\n
Be not dismayed whate'er betide,
God will take care of you;
beneath his wings of love abide,
God will take care of you.~
Refrain\n
God will take care of you,
through every day, o'er all the way;
he will take care of you,
God will take care of you.~
2\n
Through days of toil when heart doth fail,
God will take care of you;
when dangers fierce your path assail, 
God will take care of you.~
3\n
All you may need he will provide,
God will take care of you;
nothing you ask will be denied,
God will take care of you.~
4\n
No matter what may be the test,
God will take care of you;
lean, weary one, upon his breast,
God will take care of you.''',
    '''100  Great Is Thy Faithfulness+
1\n
Great is Thy faithfulness, O God my Father,
There is no shadow of turning with Thee;
Thou changest not, Thy compassions, they fail not;
As Thou has been Thou forever will be.~
Refrain\n
Great is Thy faithfulness!
Great is Thy faithfulness! 
Morning by morning new mercies I see
All I have needed Thy hand hath provided,
Great is Thy faithfulness!
Lord unto me!~
2\n
Summer and winter, and springtime and harvest,
Sun, moon, and stars in their courses above,
Join with all nature in manifold witness
To Thy great faithfulness, mercy, and love.~
3\n
Pardon for sin and a peace that endureth,
Thy own dear presence to cheer and to guide;
Strength for today and bright hope for tomorrow,
Blessings all mine, with ten thousand beside.''',
    '''101  Children of the Heavenly Father+
1\n
Children of the heavenly Father
Safely in His bossom gather;
Nestling bird nor star in heaven
Such a refuge e'er was given.~
2\n
God His own doth tend and nourish,
In His holy love they flourish;
From all evil things He spares them, 
In His mighty arms He bears them.~
3\n
Neither life nor death shall ever
From the Lord His children sever;
Unto them His grace He showeth,
And their sorrows all He knoweth.~
4\n
Praise the Lord in joyful numbers,
Your Protector never slumbers;
At the will of your Defender
Every foe-man must surrender.~
5\n
Though He giveth or He taketh,
God His children ne'er forsaketh;
His the loving purpose solely
To preserve them pure and holy.''',
    '''103  O God, Our Help in Ages Past+
1\n
O God, our help in ages past,
our hope for years to come, 
our shelter from the stormy blast,
and our eternal home!~
2\n
Under the shadow of thy throne,
still may we dwell secure;
sufficient is thine arm alone,
and our defense is sure.~
3\n
Before the hills in order stood,
or earth received her frame,
from everlasting, thou art God,
to endless years the same.~
4\n
A thousand ages, in thy sight,
are like an evening gone;
short as the watch that ends the night,
before the rising sun.~
5\n
O God, our help in ages past,
our hope for years to come;
be thou our guide while life shall last,
and our eternal home! ''',
    '''108  Amazing Grace+
1\n
Amazing grace! How sweet the sound
that saved a wretch like me!
I once was lost, but now am found;
was blind, but now I see.~
2\n
'Twas grace that taught my heart to fear,
and grace my fears relieved;
how precious did that grace appear
the hour I first believed.~
3\n
The Lord has promised good to me,
his word my hope secures;
he will my shield and portion be,
as long as life endures.~
4\n
Through many dangers, toils, and snares,
I have already come;
'tis grace hath brought me safe thus far,
and grace will lead me home.~
5\n
When we've been there ten thousand years,
bright shining as the sun,
we've no less days to sing God's praise
than when we first begun.''',
    '''109  Marvelous Grace+
1\n
Marvelous grace of our loving Lord.
Grace that exceeds our sin and our guilt!
Yonder on Calvary's mount outpoured
There where the blood of the Lamb was spilt.~
Refrain\n
Grace, grace,God's grace,
Grace that will pardon and cleanse within
Grace, grace, God's grace,
Grace that is greater than all our sin!~
2\n
Sin and despair, like the seawaves cold,
Threaten the soul with infinite loss;
Grace that is greater yes grace untold
Points to the Refuge, the mighty Cross. ~
3\n
Marvelous, infinite, matchless grace,
Freely bestowed on all who believe!
You that are longing to see His face,
Will you this moment His grace receive?''',
    '''115  O Come, O Come, Immanuel+
1\n
O come, O come, Immanuel,
And ransom captive Israel
That mourns in lonely exile here
Until the Son of God appear.~
Refrain\n
Rejoice! Rejoice! Immanuel
Shall come to thee, O Israel!~
2\n
O come, Thou Wisdom from on high,
And order all things, far and nigh;
To us the path of knowledge show,
And cause us in her ways to go.~
3\n
O come, Desire of nations, bind
All peoples in one heart and mind;
Bid envy, strife, and quarrels cease; 
Fill the whole world with heaven's peace.''',
    '''118  The First Noel+
1\n
The first noel the angel did say
Was to certain poor shepherds in fields where they lay;
In fields where they lay keeping their sheep,
On a cold winter's night that was so deep.~
Refrain\n
Noel, Noel, Noel, Noel,
Born is the King of Israel~
2\n
They looked up and say a star
Shining in the east, beyond them far,
And to the earth it gave great light,
And so it continued both day and night.~
3\n
And by the light of that same star,
Three wise men came from country far,
And to the earth it gave great light,
And to follow the star wherever it went.~
4 \n
This star drew nigh to the northwest,
O'er Bethlehem it took its rest,
And there it did both stop and stay,
Right over the place where Jesus lay.~
5\n
Then entered in those wise men three,
Full reverently upon the knee,
And offered there, in His presence,
Their gold, and myrrh, and frankincense.''',
    '''119  Angels From the Realms of Glory+
1\n
Angels from the realms of glory,
Wing your flight o`er all the earth;
Ye, who sang creation`s story,
Now proclaim Messiah`s birth;
Come and worship, Come and worship,
Worship Christ, the newborn King.~
2\n
Shepherds, in the field abiding,
Watching o`er your flocks by night,
God with man is now residing;
Yonder shines the Infant Light;
Come and worship, Come and worship,
Worship Christ, the newborn King. ~
3\n
Sages, leave your contemplations,
Brighter visions beam afar;
Seek the great Desire of nations;
Ye have seen His natal star;
Come and worship, Come and worship,
Worship Christ, the newborn King.~
4\n
Saints, before the altar bending,
Watching long in hope and fear,
Suddenly the Lord, descending,
In His temple shall appear;
Come and worship, Come and worship,
Worship Christ, the newborn King.''',

'''120  There's a Song in the Air+
1\n
There's a song in the air!
There's a star in the sky!
There's a mother's deep prayer
And a baby's low cry!
And the star rains its fire
while the beautiful sing,
For the manger of Bethlehem 
cradles a King!~
2\n
There's a tumult of joy
O'er the wonderful birth,
For the virgin's sweet boy
Is the Lord of the earth.
Aye! the star rains its fire
while the beautiful sing,
For the manger of Bethlehem
cradles a King!~
3\n
In the light of that star
Lie the ages impearled;
And that song from afar
Has swept over the world.
Every hearth is aflame
and the beautiful sing
In the homes of the nations
that Jesus is King!~
4\n
We rejoice in the light,
And we echo the song
That comes down through the night
From the heavenly throng.
Aye! we shout to the lovely evangel they bring,
And we greet in His cradle 
our Savior and King!''',



'''122  Hark! the Herald Angels Sing+
1\n
Hark! the herald angels sing,
"Glory to the new born King,
peace on earth, and mercy mild,
God and sinners reconciled!"
Joyful, all ye nations rise,
join the triumph of the skies;
with th' angelic host proclaim,
"Christ is born in Bethlehem!"
Hark! the herald angels sing,
"Glory to the new born King!"~
2\n
Christ, by highest heaven adored;
Christ, the everlasting Lord;
late in time behold him come,
offspring of a virgin's womb.
Veiled in flesh the Godhead see;
hail th' incarnate Deity, 
pleased with us in flesh to dwell,
Jesus, our Emmanuel.
Hark! the herald angels sing,
"Glory to the new born King!"~
3\n
Hail the heaven-born Prince of Peace!
Hail the Sun of Righteousness!
Light and life to all he brings,
risen with healing in his wings.
Mild he lays his glory by,
born that we no more may die,
born to raise us from the earth,
born to give us second birth.
Hark! the herald angels sing,
"Glory to the new born King!"''',
  '''123  As With Gladness Men of Old+
1\n
As with gladness, men of old
Did the guiding star behold
As with joy they hailed its light
Leading onward, beaming bright
So, most glorious Lord, may we
Evermore be led to Thee. ~
2\n
As with joyful steps they sped
To that lowly manger bed
There to bend the knee before
Him Whom heaven and earth adore;
So may we with willing feet
Ever seek Thy mercy seat.~
3\n
As they offered gifts most rare
At that manger rude and bare;
So may we with holy joy,
Pure and free from sin's alloy,
All our costliest treasures bring,
Christ, to Thee, our heavenly King.~
4\n
Holy Jesus, every day
Keep us in the narrow way;
And, when earthly things are past,
Bring our ransomed souls at last
Where they need no star to guide,
Where no clouds Thy glory hide.~
5\n
In the heavenly country bright,
Need they no created light;
Thou its light, its joy, its crown, 
Thou its sun which goes not down;
There forever may we sing
Alleluias to our King!''',
  '''125  Joy to the World+
1\n
Joy to the world,
the Lord is come!
Let earth
receive her King;
Let every heart
prepare Him room,
And heaven and nature sing,
And heaven and nature sing,
And heaven, and heaven
and nature sing.~
2\n
Joy to the earth,
the Savior reigns!
Let men their
songs employ;
While fields and floods, 
rocks, hills, and plains,
Repeat the sounding joy,
Repeat the sounding joy,
Repeat, repeat
the sounding joy.~
3\n
No more let sin
and sorrow grow,
Nor thorns
infest the ground;
He comes to make
His blessings flow
Far as the curse is found,
Far as the curse is found,
Far as, far as
the curse is found.~
4\n
He rules the world
with truth and grace,
And makes the
nations prove
The glories of
His righteousness,
And wonders of His love,
And wonders of His love,
And wonders, and
wonders of His love.''',
  '''128  Break Forth, O Beauteous Heavenly Light+
1\n
Break forth, O beautiful heavenly light,
And usher in the morning;
Ye shepherds, shrink not with affright,
But hear the abgel's warning.
This child, now weak in infancy,
Our confidence and joy shall be,
The power of Satan breaking,
Our peace eternal making.~
2\n
Break forth, O beauteous heavenly light
To herald our salvation;
He stoops to earth-the God of might,
Our hope and expectation.
He comes in human flesh to dwell,
Our God with us, Immanuel,
The night of darkness ending,
Our fallen race befriending.''',
  '''130  It Came Upon the Midnight Clear+
1\n
It came upon the midnight clear,
that glorious song of old,
from angels bending near the earth
to touch their harps of gold;
"Peace on earth, goodwill to men,
from heav'n's all gracious King!"
The world in solemn stillness lay
to hear the angels sing.~
2\n
Still through the cloven skies they come,
with peaceful wings unfurled;
And still their heav'nly music floats
o'er all the weary world;
Above its sad and lowly plains
they bend on hovering wing;
And ever o'er its Babel sounds
the blessed angels sing!~
3\n
Yet with the woes of sin and strife
the world has suffered long;
beneath the angel strain have rolled
two thousand years of wrong;
And man, at war with man, hears not
the love song which they bring
O hush the noise, ye men of strife, 
and hear the angels sing!~
4\n
For lo! The days are hast'ning on,
by prophet bards foretold,
When, with the ever circling years,
comes round the age of gold;
When peace shall over all the earth
its ancient splendors fling;
And the whole world send back
the song which now the angels sing!''',
  '''131  Lo, How a Rose E'er Blooming+
1\n
Lo, how a rose e're blooming
From tenderstem hath sprung,
Of Jesse's lineage coming
As men of old have sung.
It came, a floweret bright,
Amid the cold of winter
When half spent was the night.~
2 \n
Isaiah 'twas foretold it,
The Rose I have in mind,
With Mary we beheld it,
The virgin mother kind.
To show God's love aright
She bore to them a Savior,
When half spent was the night.''',
  '''132  O Come, All Ye Faithful+
1\n
O come, all ye faithful,
joyful and triumphant,
O come ye, O come
ye to Bethlehem!
Come and behold Him,
born the King of angels!
O come, let us adore Him,
O come, let us adore Him,
O come, let us adore
Him, Christ, the Lord!~
2\n
Sing, choirs of angels 
sing in exultation,
O sing all ye citizens
of heaven above!
Glory to God, all
glory in the highest!
O come, let us adore Him,
O come, let us adore Him,
O come, let us adore
Him, Christ, the Lord!~
3\n
Yea, Lord, we greet Thee,
born this happy morning,
Jesus, to Thee be
all glory given;
Word of the Father,
now in flesh appearing!
O come, let us adore Him,
O come, let us adore Him,
O come, let us adore
Him, Christ, the Lord!''',
  '''135  O Little Town of Bethlehem+
1\n
O little town of Bethlehem 
How still we see thee lie!
Above thy deep and dreamless
sleep The silent stars go by;
Yet in thy dark streets shineth
The everlasting light;
The hopes and fears of all the
years Are met in thee tonight.~
2\n
For Christ is born of Mary;
And gathered all above,
While mortals sleep,
the angels keep
Their watch of
wondering love.
O morning stars, together
Proclaim the holy birth!
And praises sing to God the King,
And peace to men on earth.~
3\n
How silently, how silently
The wondrous gift is given!
So God imparts to human hearts
The blessings of His heaven.
No ear may hear His coming;
But in this world of sin,
Where meek souls will
recieve Him still, 
The dear Christ
enters in.~
4\n
O holy Child of Bethlehem,
Descend to us, we pray;
Cast out our sin and enter
in-- Be born in us today.
We hear the Christmas angels
The great glad tidings tell--
Oh, come to us, abide with us,
Our Lord Immanuel!''',

 '''137  We Three Kings+
1\n
We three kings of Orient are;
Bearing gifts we traverse afar
Field and fountain, moor and mountain,
Following yonder star.~
Refrain\n
O star of wonder, star of night,
Star with royal beauty bright,
Westward leading, still proceeding,
Guide us to Thy perfect light.~
2\n
Born a King on Bethlehem's plain,
Gold I bring to crown Him again,
King forever, ceasing never
Over us all to reign.~
3\n
Frankincense to offer have I;
Incense owns a Deity nigh;
Prayer and praising all men raising,
Worship Him, God on high.~
4\n
Myrrh is mine; its bitter perfume
Breathes a life of gathering gloom:
Sorrowing, sighing, bleeding, dying,
Sealed in the stonecold tomb.~
5\n
Glorious now behold Him arise,
King and God and sacrifice;
Alleluia, Alleluia!
Sounds through the earth and skies.''',

'''138  Rise Up, Shepherd, and Follow+
1\n
There's a star in the east on Christmas morn.
Rise up shepherd, and follow.
It will lead to the place where the Savior's born,
Rise up shepherd, and follow.~
Refrain\n
Leave your sheep and leave your lambs,
Rise up, shepherd, and follow.
Leave your ewes and leave your rams,
Rise up shepherd, and follow.
Follow, follow, Rise up, shepherd and follow.
Follow the star of Behlehem, Rise up, shepherd, and follow.~
2\n
If you take good heed to the angel's words,
Rise up, shepherd, and follow.
You'll forget your flocks, you'll forget your herds,
Rise up, shepherd, and follow.''',

 '''141  What Child Is This?+
1\n
What child is this, who, laid to rest,
On Mary`s lap is sleeping? 
Whom angels greet with anthems sweet,
While shepherds watch are keeping?~
Refrain\n
This, this is Christ the King,
Whom shepherds guard and angels sing:
Haste, haste to bring Him laud,
The babe, the son of Mary.~
2\n
Why lies He in such mean estate
Where ox and ass are feeding?
Good Christian, fear: for sinners here
The silent Word is pleading.~
3\n
So bring Him incense, gold, and myrrh,
Come, peasant, king, to own Him,
The King of kings salvation brings,
Let loving hearts enthrone Him.''',


'''142  Angels We Have Heard on High+
1\n
Angels we have heard on high,
Singing sweetly through the night,
And the mountains, in reply,
Echoing their brave delight.~
Refrain\n
Gloria, in excelsis Deo,
Gloria in excelsis Deo.~
2\n
Shepherds, why this jubilee?
Why this songs of happy cheer?
What great brightness did you see?
What glad tidings did you hear?~
3\n
Come to Bethlehem and see
Him whose birth the angels sing;
Come adore, on bended knee,
Christ the Lord, the newborn King.~
4\n
See Him in a manger laid,
Whom the angels praise above;
Mary, Joseph, lend your aid,
While we raise our hearts in love.''',


'''143  Silent Night, Holy Night+
1\n
Silent night! holy night!
All is calm, all is bright
Round yon virgin mother and Child, 
Holy Infant so tender and mild,
Sleep in heavenly peace,
sleep in heavenly peace.~
2\n
Silent night! holy night!
Shepherds quake at the sight,
glories stream from heaven afar,
heavenly hosts sing Alleluia;
Christ, the Savior is born,
Christ, the Savior is born.~
3\n
Silent night! holy night!
Son of God, love's pure light,
Radiant beams from Thy holy face,
with the dawn of redeeming grace,
Jesus, Lord, at Thy birth,
Jesus, Lord, at Thy birth.
''',

'''146  I Think When I Read That Sweet Story+
1\n
I think when I read that sweet story of old,
When Jesus was here among men,
How He called little children
as lambs to His fold,
I should like to have been with Him then. ~
2\n
I wish that His hands had been placed on my head,
That His arm had been thrown around me,
And that I might have seen His kind
look when He said,
"Let the little ones come unto Me."~
3\n
I long for the joy of that glorious time,
The sweetest and brightest and best,
When the dear little children of every clime
Shall crowd to His arms and be blest.''',

'''152  Tell Me the Story of Jesus+
1\n
Tell me the story of Jesus,
Write on my heart every word,
Tell me the story most precious
Sweetest that ever was heard;
Tell how the angels, in chorus,
Sang as they welcomed His birth,
Glory to God in the highest,
Peace and good tidings to earth.~
Refrain\n
Tell me the story of Jesus,
Write on my heart every word,
Tell me the story most precious,
Sweetest that ever was heard.~
2\n
Fasting, alone in the desert,
Tell of the days that He passed,
How for our sins He was tempted,
Yet was triumphant at last;
Tell of the years of His labor,
Tell of the sorrow He bore,
He was despised and afflicted,
Homeless, rejected, and poor.~
3\n
Tell of the cross where they nailed Him,
Writhing in anguish and pain;
Tell of the grave where they laid Him,
Tell how He liveth again;
Love in that story so tender,
Clearer than ever I see;
Stay, let me weep while you whisper,
Love paid the ransom for me.''', 

'''154  When I Survey the Wondrous Cross+
1\n
When I survey the wondrous cross
on which the Prince of Glory died;
my richest gain I count but loss,
and pour contempt on all my pride.~
2\n
Forbid it, Lord, that I should boast,
save in the death of Christ, my God;
all the vain things that charm me most,
I sacrifice them to his blood.~
3\n
See, from his head, his hands, his feet,
sorrow and love flow mingled down.
Did e'er such love and sorrow meet,
or thorns compose so rich a crown.~
4\n
Were the whole realm of nature mine,
that were an offering far too small;
love so amazing, so divine,
demands my soul, my life, my all.''',

'''156  O Sacred Head Now Wounded +
1\n
O sacred Head, now wounded,
with grief and shame weighed down,
now scornfully surounded
with thorns, thine only crown:
how pale thou art with anguish,
with sore abuse and scorn!
How does that visage languish
which once was bright as morn!~
2\n
What thou, my Lord, has suffered
was all for sinners' gain;
mine, mine was the transgression,
but thine the deadly pain.
Lo, here I fall, my Savior!
'Tis I deserve thy place;
look on me with thy favor,
vouchsafe to me thy grace.~
3\n
What language shall I borrow
to thank thee, dearest friend,
for this thy dying sorrow,
thy pity without end?
O make me thine forever;
and should I fainting be,
Lord, let me never, never 
outlive my love for thee.''',
'''157  Go to Dark Gethsemane+
1\n
Go to dark Gethsemane,
ye that feel the tempter's power;
your Redeemer's conflict see,
watch with him one bitter hour.
Turn not from his griefs away;
learn of Jesus Christ to pray.~
2\n
See him at the judgment hall,
beaten, bound, reviled, arraigned;
O the wormwood and the gall!
O the pangs his soul sustained!
Shun not suffering, shame, or loss;
learn of Christ to bear the cross.~
3\n
Calvary's mournful mountain climb;
there, adoring at his feet,
mark that miracle of time,
God's own sacrifice complete. 
"It is finished!" hear him cry;
learn of Jesus Christ to die.''',

'''159  The Old Rugged Cross+
1\n
On a hill far away stood an old rugged cross,
the emblem of suffering and shame;
and I love that old cross where the dearest and best
for a world of lost sinners was slain.~
Refrain\n
So I'll cherish the old rugged cross,
till my trophies at last I lay down;
I will cling to the old rugged cross,
and exchange it some day for a crown.~
2\n
O that old rugged cross, so despised by the world,
has a wondrous attraction for me;
for the dear Lamb of God left his glory above
to bear it to dark Calvary.~
3\n
To that old rugged cross I will ever be true,
its shame and reproach gladly bear;
then he'll call me some day to my home far away,
where his glory forever I'll share.''',

'''163  At the Cross+
1\n
Alas! and did my Savior bleed,
and did my Sovereign die?
Would he devote that sacred head
for sinners such as I?~
Refrain\n
At the cross, at the cross,
where I first saw the light,
and the burden of my heart rolled away;
it was there by faith I received my sight,
and now I am happy all the day!~
2\n
Was it for crimes that I have done,
he groaned upon the tree?
Amazing pity! Grace unknown!
And love beyond degree!~
3\n
But drops of grief can ne'er repay
the debt of love I owe:
Here, Lord, I give myself away;
'tis all that I can do!''' , 
''' 166  Christ the Lord Is Risen Today+
1\n
Christ the Lord is risen today, Alleluia!
Sons of man and angels say, Alleluia!
Raise your joys and triumphs high, Alleluia!
Sing, ye heavens, and earth reply, Alleluia!~
2\n
Lives again our glorious King, Alleluia!
Where, O death, is now thy sting? Alleluia!
Once he died our souls to save, Alleluia!
Where's thy victory, boasting grave? Alleluia!~
3\n
Love's redeeming work is done, Alleluia!
Fought the fight, the battle won, Alleluia!
Death in vain forbids him rise, Alleluia!
Christ has opened paradise, Alleluia!~
4\n
Soar we now where Christ has led, Alleluia!
Following our exalted Head, Alleluia!
Made like him, like him we rise, Alleluia!
Ours the cross, the grave, the skies, Alleluia!''' ,
''' 171  Thine Is the Glory +
1\n
Thine is the glory,
Risen, conquering Son;
Endless is the victory
Thou o'er death hast won.
Angels in bright raiment
Rolled the stone away,
Kept the folded grave-clothes
Where Thy body lay.~
Refrain\n
Thine is the glory,
Risen, conquering Son;
Endless is the victory
Thou o'er death hast won.~
2\n
Lo! Jesus meets us.
Risen from the tomb,
Lovingly He greets us,
Scatters fear and gloom;
Let His Church with gladness
Hymns of triumph sing,
For her Lord now liveth;
Death has lost its sting.~
3\n
No more we doubt Thee,
Glorious Prince of life! 
Life is nought without Thee;
Aid us in our strife;
Make us more than conquerors,
Through Thy deathless love;
Bring us safe through Jordan
To Thy home above.''',

'''181  Does Jesus Care?+
1\n
Does Jesus care when my heart is pained
Too deeply for mirth and song;
As the burdens press, and the cares distress,
And the way grows weary and long?~
Refrain\n
O yes, He cares- I know He cares!
His heart is touched with my grief;
When the days are weary,
The long nights dreary,
I know my Savior cares. (He cares.)~
2\n
Does Jesus care when my way is dark
With a nameless dread and fear?
As the daylight fades into deep night shades, 
Does He care enough to be near?~
3\n
Does Jesus care when I've said goodbye
To the dearest on earth to me,
And my sad heart aches till it nearly breaks -
Is it aught to Him? Does He see?''',
'''182  Christ Is Alive+
1\n
Christ is alive!
Let Christians sing.
His cross stands empty to the sky.
Let streets and homes with praises ring.
His love in death shall never die.~
2\n
Christ is alive!
No longer bound
To distant years in Palestine,
He comes to claim the here and now
And conquer every place and time.~
3\n
In every insult,
rift, and war
Where color, scorn or wealth divide,
He suffers still, yet loves the more, 
And lives, though ever crucified.~
4\n
Christ is alive!
Ascended Lord
He rules the world His Father made,
Till, in the end, His love adored
Shall be to all on earth displayed.''',

'''183  I Will Sing of Jesus' Love+
1\n
I Will sing of Jesus love,
Sing of Him,who first loved me;
for He left bright worlds above,
And died on Calvary.~
Refrain\n
I will sing of Jesus love
Endless praise my heart shall give;
He has died that I might live
I will sing His love to me.~
2\n
O the depths of love divine!
Earth or heaven can never know
How that sin as dark as mine
can be made as white as snow. ~
3\n
Nothing good for Him I've done;
How could He such love bestow?
Lord, I own my heart is won,
help me now my love to show.''',

'''184  Jesus Paid It All+
1\n
I hear the Savior say,
"Thy strength indeed is small;
Child of weakness, watch and pray,
Find in Me thine all in all."~
Refrain\n
Jesus paid it all,
All to Him I owe;
Sin had left a crimson stain;
He washed it white as snow.~
2\n
Lord, now indeed I find
Thy power, and Thine alone,
Can change the leper's spots,
And melt the heart of stone.~
3\n
Since nothing good have I
Whereby Thy grace to claim,
I'll wash my garment white
In the blood of Calvary's Lamb.~
4\n
And when before the throne
I stand in Him complete,
I'll lay my trophies down,
All down at Jesus' feet.''',

'''185  Jesus Is All the World to Me+
1\n
Jesus is all the world to me,
my life, my joy, my all;
he is my strength from day to day,
without him I would fall.
When I am sad, to him I go,
no other one can cheer me so;
when I am sad, he makes me glad,
he's my friend.~
2\n
Jesus is all the world to me, 
my friend in trials sore;
I go to him for blessings, and
he gives them o'er and o'er.
He sends the sunshine and the rain,
he sends the harvest's golden grain;
sunshine and rain, harvest of grain,
he's my friend.~
3\n
Jesus is all the world to me,
and true to him I'll be;
O how could I this friend deny,
when he's so true to me?
Following him I know I'm right,
he watches o'er me day and night;
following him by day and night,
he's my friend.~
4\n
Jesus is all the world to me,
I want no better friend;
I trust him now, I'll trust him when
life's fleeting days shall end.
Beautiful life with such a friend,
beautiful life that has no end;
eternal life, eternal joy,
he's my friend.''', 

'''186  I've Found a Friend+
1\n
I've found a Friend; oh, such a Friend!
He loved me ere I knew Him;
He drew me with the cords of love,
And thus He bound me to Him.
And 'round my heart still closely twine
Those ties which nought can sever,
For I am His, and He is mine,
Forever and forever.~
2\n
I've found a Friend; oh, such a Friend!
He bled, He died to save me;
And not alone the gift of life,
But His own self He gave me.
Nought that I have my own I call,
I hold it for the Giver;
My heart, my strength, my life my all,
Are His, and His forever.~
3\n
I've found a Friend; oh, such a Friend!
All power to Him is given; 
To guard me on my upward course,
And bring me safe to heaven.
The eternal glories gleam afar,
To nerve my faint endeavor;
So now to watch, to work, to war,
And then to rest forever.~
4\n
I've found a Friend; oh, such a Friend!
So kind, and true, and tender,
So wise a counselor and guide,
So mighty a defender.
From Him, who loveth me so well,
What power my soul can sever?
Shall life or death, or earth, or hell?
No; I am His forever.''',

'''190  Jesus Loves Me+
1\n
Jesus loves me! this I know,
For the Bible tells me so;
Little ones to Him belong
They are weak but He is strong ~
Refrain\n
Yes, Jesus loves me!
Yes, Jesus loves me!
Yes, Jesus loves me!
The Bible tells me so.~
2\n
Jesus loves me! He wo died
Heaven's gate to open wide:
He will wash away my sin,
Let His little child come in.~
3\n
Jesus, take this heart of mine,
Make it pure and wholly thine;
On the coross You died for me,
I will love and live for Thee.''',

'''191  Love Divine+
1\n
Love divine, all loves excelling,
joy of heaven, to earth come down;
fix in us thy humble dwelling;
all thy faithful mercies crown!
Jesus thou art all compassion,
pure, unbounded love thou art; 
visit us with thy salvation;
enter every trembling heart.~
2\n
Breathe, O breathe thy loving Spirit
into every troubled breast!
Let us all in thee inherit;
let us find that second rest.
Take away our bent to sinning;
Alpha and Omega be;
end of faith, as its beginning,
set our hearts at liberty.~
3\n
Come, Almighty to deliver,
let us all thy life receive;
suddenly return and never,
nevermore thy temples leave.
Thee we would be always blessing,
serve thee as thy hosts above,
pray and praise thee without ceasing,
glory in thy perfect love.~
4\n
Finish, then, thy new creation;
pure and spotless let us be.
Let us see thy great salvation
perfectly restored in thee;
changed from glory into glory, 
till in heaven we take our place,
till we cast our crowns before thee,
lost in wonder, love, and praise.''',

'''195  Showers of Blessing+
1\n
"There shall be showers of blessing;"
This is the promise of love;
There shall be seasons refreshing,
Sent from the Savior above.~
Refrain\n
Showers of blessing,
Showers of blessing we need;
Mercy drops round us are falling,
But for the showers we plead.~
2\n
"There shall be showers of blessing;"
Precious reviving again;
Over the hills and the valleys,
Sound of abundance of rain. ~
3\n
"There shall be showers of blessing;"
Send them upon us, O Lord;
Grant to us now a refreshing;
Come, and now honor Thy word.~
4\n
"There shall be showers of blessing;"
O that today they might fall,
Now as to God were confessing,
Now as on Jesus we call!''',

'''196  Tell Me the Old, Old Story+
1\n
Tell me the old, old story, Of unseen things above,
Of Jesus and His glory, Of Jesus and His love;
Tell me the story simply, As to a little child,
For I am weak and weary, And helpless and defiled.~
2\n
Tell me the story softly, With earnest tones and grave;
Remember I'm the sinner Whom Jesus came to save;
Tell me the story always, If you would really be,
In any time of trouble, A comforter to me. ~
3\n
Tell me the same old story, When you have cause to fear
That this world's empty glory Is costing me too dear;
Yes, and when that world's glory Is dawning on my soul,
Tell me the old, old story: "Christ Jesus makes thee whole." ''',

'''198  And Can It Be?+
1\n
And can it be that I should gain
an interest in the Savior's blood!
Died he for me? who caused his pain!
For me? who him to death pursued?
Amazing love! How can it be
that thou, my God, shouldst die for me?~
Refrain\n
Amazing love! How can it be
that thou, my God, shouldst die for me?~
2\n
He left his Father's throne above
so free, so infinite his grace!; 
emptied himself of all but love,
and bled for Adam's helpless race.
'Tis mercy all, immense and free,
for O my God, it found out me!~
3\n
Long my imprisoned sprit lay,
fast bound in sin and nature's night;
thine eye diffused a quickening ray;
I woke, the dungeon flamed with light;
my chains fell off, my heart was free,
I rose, went forth, and followed thee.~
4\n
No condemnation now I dread;
Jesus, and all in him, is mine;
alive in him, my living Head,
and clothed in righteousnes divine,
bold I approach th' eternal throne,
and claim the crown, through Christ my own.''',

'''201  Christ Is Coming+
1\n
Christ is coming! let creation
Bid her groans and travail cease; 
Let the glorious proclamation
Hope restore and faith increase;
Christ is coming! Christ is coming!
Come, Thou blessed Prince of Peace!
(Prince of Peace!)
Come, Thou blessed Prince of Peace!~
2\n
Earth can now but tell the story
Of Thy bitter cross and pain;
She shall yet behold Thy glory
When Thou comest back to reign;
Christ is coming! Christ is coming!
Let each heart repeat the strain.
(repeat the strain)
Let each heart repeat the strain.~
3\n
With that "blessed hope" before us,
Let no harp remain unstrung;
Let the mighty advent chorus
Onward roll from tongue to tongue:
Christ is coming! Christ is soling!
Come, Lord Jesus, quickly come!
(quickly come!)
Come, Lord Jesus, quickly come! ''',

'''202  Hail Him the King of Glory+
1\n
Tell it to every kindred and nation,
Tell it far and near;
Earth's darkest night will fade with the dawning,
Jesus will soon appear.~
Refrain\n
Hail Him the king of glory,
Once the Lamb for sinners slain;
Tell, tell the wondrous story,
"Jesus comes to reign."~
2\n
Nations again in strife and commotion,
Warnings by the way;
Signs in the heavens, unerring omens,
Herald the glorious day.~
3\n
Children of God look up with rejoicing;
Shout and sing His praise;
Blessed are they who, waiting and watching,
Look for the dawning rays. ''',

'''204  Come, Thou Long Expected Jesus+
1\n
Come, thou long expected Jesus!
born to set thy people free;
from our fears and sins release us,
let us find our rest in thee.
Israel's strength and consolation,
hope of all the earth thou art;
dear desire of every nation,
joy of every longing heart.~
2\n
Born thy people to deliver,
born a child and yet a King,
born to reign in us forever,
now thy gracious kingdom bring.
By thine own eternal spirit
rule in all our hearts alone;
by thine all sufficient merit,
raise us to thy glorious throne.''',

'''205  Gleams of the Golden Morning+
1\n
The golden morning is fast approaching;
Jesus soon will come
To take his faithful and happy children
to their promised home~
Refrain\n
O, we see the gleams of the golden morning
piercing thro' this night of gloom!
O, see the gleams of the golden morning
that will burst the tomb.~
2\n
The gospel summons will soon be carried
to the nations round;
The Bridegroom then will cease to tarry
and the trumpet sound.~
3\n
Attended by all the shining angels,
Down the flaming sky
the Judge will come, and will take his people
where they will not die.~
4\n
The lov'd of earth who have long been parted,
Meet in that glad day;
The tears of those who are broken hearted
shall be wiped away. ''',

'''206  Face to Face+
1\n
Face to face with Christ my Savior,
Face to face, what will it be,
When with rapture I behold Him,
Jesus Christ, who died for me?~
Refrain\n
Face to face shall I behold Him,
Far beyond the starry sky;
Face to face in all His glory
I shall see Him by and by!~
2\n
Only faintly now I see Him,
With the darkening veil between,
But a blessed day is coming,
When His glory shall be seen.~
3\n
What rejoicing in His presence,
When are banished grief and pain;
When the crooked ways are straightened,
And the dark things shall be plain! ~
4\n
Face to face! oh, blissful moment!
Face to face to see and know;
Face to face with my Redeemer,
Jesus Christ, who loves me so.''',


'''207  It May Be at Morn+
1\n
It may be at morn, when the day is awaking,
When sunlight through darkness and shadow is breaking,
That Jesus will come in the fullness of glory
To receive from the world His own.~
Refrain\n
O Lord Jesus, how long, how long
Ere we shout the glad song?
Christ returneth, Hallelujah!
Hallelujah! Amen, Hallelujah! Amen.~
2\n
It may be at midday, it may be at twilight,
It may be, perchance, that the blackness of midnight
Will burst into light in the blaze of His glory, 
When Jesus receives His own.~
3\n
O joy! O delight! should we go without dying,
No sickness, no sadness, no dread, and no crying,
Caught up through the clouds with our Lord into glory,
When Jesus receives His own.''',

'''208  There'll Be No Dark Valley+
1\n
There'll be no dark valleys when Jesus comes,
There'll be no dark valleys when Jesus comes,
There'll be no dark valleys when Jesus comes,
To gather His loved ones home.~
Refrain\n
To gather His loved ones home,
To gather His loved ones home.
There'll be no dark valleys when Jesus comes,
To gather His loved ones home.~
2\n
There'll be no more sorrow when Jesus comes,
There'll be no more sorrow when Jesus comes,
There'll be a happy tomorrow when Jesus comes,
To gather His loved ones home. ~
3\n
There'll be songs of greeting when Jesus comes,
There'll be songs of greeting when Jesus comes,
There'll be songs of greeting when Jesus comes,
To gather His loved ones home.''',

'''210  Wake, Awake. for the Night Is Flying+
1\n
Wake, awake, for night is flying,
The watchmen on the heights are crying,
Awake, Jerusalem, arise!
Midnight's solemn hour is tolling,
His chariot wheels are nearer rolling,
He comes; prepare, ye virgins wise.
Rise up with willing feet
Go forth, the Bridegroom meet; Alleluia!
Bear through the night your well-trimmed light,
Speed forth to join the marriage rite.~
2\n
Zion hears the watchmen singing,
Her heart with deep delight is springing,
She wakes, she rises from her gloom;
Forth her Bridegroom comes, all-glorious,
In grace arrayed, by truth victorious;
Her Star is risen, her Light is come!
All hail, incarnate Lord, 
Our crown, and our reward! Alleluia!
We haste along, in pomp and song,
And gladsome join the marriage throng.~
3\n
Lamb of God, the heavens adore Thee,
And men and angels sing before Thee,
With harp and cymbal's clearest tone.
By the pearly gates in wonder
We stand, and swell the voice of thunder,
That echoes round Thy dazzling throne.
No vision ever brought,
No ear hath ever caught,
Such bliss and joy;
We raise the song, we swell the throng,
To praise Thee ages all along.''',

'''213  Jesus Is Coming Again+
1\n
Lift up the trumpet, and loud let it ring:
Jesus is coming again!
Cheer up, ye pilgrims, be joyful and sing:
Jesus is coming again!~
Refrain\n
Coming again, coming again, 
Jesus is coming again!~
2\n
Echo it, hilltops; proclaim it, ye plains:
Jesus is coming again!
Coming in glory, the Lamb that was slain;
Jesus is coming again!~
3\n
Heavings of earth, tell the vast, wondering throng:
Jesus is coming again!
Tempests and whirlwinds, the anthem prolong;
Jesus is coming again!~
4\n
Nations are angry-by this we do know
Jesus is coming again!
Knowledge increases; men run to and fro;
Jesus is coming again!''',

'''216  When the Roll Is Called Up Yonder+
1\n
When the trumpet of the Lord shall sound,
and time shall be no more,
And the morning breaks, eternal, bright and fair;
When the saved of earth shall gather
over on the other shore,
And the roll is called up yonder, I'll be there. ~
Refrain\n
When the roll is called up yonder,
When the roll is called up yonder,
When the roll is called up yonder,
When the roll is called up yonder, I'll be there.~
2\n
On that bright and cloudless morning,
when the dead in Christ shall rise,
And the glory of His resurection share;
When His chosen ones shall gather
to their home beyond the skies,
And the roll is called up yonder, I'll be there.~
3\n
Let us labor for the Master
from the dawn till setting sun,
Let us talk of all His wondrous love and care,
Then, when all of life is over,
and our work on earth is done,
And the roll is called up yonder I'll be there.''',

'''221  Rejoice, the Lord Is King +
1\n
Rejoice, the Lord is King!
Your Lord and King adore!
Rejoice, give thanks, and
sing and triumph evermore:
Lift up your heart,
lift up your voice!
Rejoice, again
I say, rejoice!~
2\n
Jesus, the Savior, reigns,
The God of truth and love;
When He had purged our stains,
He took His seat above:
Lift up your heart,
lift up your voice!
Rejoice, again
I say, rejoice!~
3\n
His kingdom cannot fail,
He rules o'er earth and heaven;
The keys of death and grave
Are to our Jesus given:
Lift up your heart,
lift up your voice!
Rejoice, again
I say, rejoice! ~
4\n
Rejoice in glorious hope!
Our Lord the judge shall come,
And take His servants up
To their eternal home:
Lift up your heart,
lift up your voice!
Rejoice, again
I say, rejoice!''',

'''222  Hark! Ten Thousand Harps and Voices+
1\n
Hark! ten thousand harps and voices
Sound the note of praise above;
Jesuse reigns, and heaven rejoices,
Jesus reigns, the God of love:
See, He sits on yonder throne;
Jesus rules the world alone.
Alleluia! Alleluia!
Alleluia! Amen.~
2\n
King of glory, reign forever,
Thine an everlasting crown;
Nothing from Thy love shall sever
Those whom Thou hast made Thine own;
Happy objects of Thy grace,
Destined to behold Thy face.
Alleluia! Alleluia!
Alleluia! Amen.~
3\n
Savior, hasten Thine appearing;
Bring, O bring the glorious day,
When, the awful summons hearing,
Heaven and earth shall pass away:;
Then, with golden harps we'll sing,
"Glory, glory to our King!"
Alleluia! Alleluia!
Alleluia! Amen.'''
  ];

  Hym _toHym(String rawHym) {
    Map<dynamic, String> versesMap = {};
    // String verses=' errror causing';
    //  var individualVerses=[];

    // print(rawHym);

    var firstSplit = rawHym.split("+\n");
    
    var number = firstSplit[0].split("  ")[0];
    // print("hym $number error");
    var title = firstSplit[0].split("  ")[1];
      var verses = firstSplit[1];
    
    var individualVerses = verses.split("~\n");

//     print("individual verses are ${individualVerses.toString()}");

    print("good till here,");
    int i = 0;
  
    individualVerses.forEach((hym) {
      
      try {
        versesMap[hym.split('\n\n')[0]] = hym.split('\n\n')[1];
      } catch (e) {
        print("error on item $i");
        print("\n $e");
      } finally {
        i++;
      }
    });

    return Hym(
        author: "Unknown",
        number: int.parse(number),
        title: title,
        noVerses: individualVerses.length,
        verses: versesMap,
        category: HelperFunctions.getHymCategory(int.parse(number)),
        musicFile: "hym_$number.mp3");
  }

  List<Hym> createAllHyms() {
    List<Hym> finalHyms = [];

    allHyms.forEach((hym) {
      finalHyms.add(_toHym(hym));
    });

    return finalHyms;
  }
}
