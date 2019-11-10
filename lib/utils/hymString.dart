import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/hym.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';

class AllHyms {

   

   List<String> allHyms=[
 
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
Surely His goodness and mercy here daily attend thee. Ponder anew what the Almighty can do,If with His love He befriend thee.'''

,

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
our Savior and King!'''



];
     
     Hym _toHym(String rawHym) {

    Map<dynamic, String> versesMap={};
    // String verses=' errror causing';
    //  var individualVerses=[];

    // print(rawHym);

    var firstSplit = rawHym.split("+\n");
//     print(firstSplit);
    var number = firstSplit[0].split("  ")[0];
    var title = firstSplit[0].split("  ")[1];

    var verses = firstSplit[1];
     var individualVerses = verses.split("~\n");
   
//     print("individual verses are ${individualVerses.toString()}");

print("good till here");
int i=0;
    
    individualVerses.forEach((hym) {
      
      
      try{versesMap[hym.split('\n\n')[0]] = hym.split('\n\n')[1];}
      catch(e){
        print("error on item $i");
        print("\n $e");
      }
      finally{
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
        musicFile: "hym_$number.mp3"
        );
  }

  List<Hym> createAllHyms() {
    List <Hym> finalHyms=[];

    allHyms.forEach((hym){
      
      finalHyms.add(  _toHym(hym));
    });

    return finalHyms;
  }
}
