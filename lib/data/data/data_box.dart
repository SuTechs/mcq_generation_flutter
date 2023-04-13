import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcq_generation_flutter/data/data/data.dart';

class DataBox {
  static const _userKey = 'users';
  static const _curseKey = 'courses';
  static const loggedInUserKey = 'loggedInUser';

  static Box<UserData> userBox = Hive.box<UserData>(_userKey);
  static Box<CourseData> courseBox = Hive.box<CourseData>(_curseKey);

  static ValueListenable<Box<UserData>> get loggedInUserListenable =>
      userBox.listenable(keys: [loggedInUserKey]);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(CourseDataAdapter());

    /// opening box

    await Hive.openBox<UserData>(_userKey);
    await Hive.openBox<CourseData>(_curseKey);

    /// add some pre-data

    // adding admin
    userBox.put(
        'admin@admin.com', UserData('Admin', 'admin@admin.com', 'admin123'));

    // adding course

    if (courseBox.isEmpty) {
      for (final c in _courses) {
        courseBox.put(c.name, c);
      }
    }
  }

  /// some helper methods for users

  static void login(UserData userData) => userBox.put(loggedInUserKey,
      UserData(userData.name, userData.email, userData.password));

  static void logout() => userBox.delete(loggedInUserKey);

  static UserData? getUserByEmail(String email) => userBox.get(email);

  static void signup(UserData userData) {
    userBox.put(userData.email, userData);
    login(userData);
  }
}

/// course data
List<CourseData> _courses = [
  CourseData(
    name: 'Introduction to computer programming',
    description: 'Learn the basics of the computer programming',
    imageUrl:
        'https://images.pexels.com/photos/3861958/pexels-photo-3861958.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    courseContent: """
       UNIT-I INTRODUCTION TO COMPUTERS

COMPUTER SYSTEMS
“A Computer is an electronic device that stores, manipulates and retrieves the data.” We can also refer computer computes the information supplied to it and generates data.
A System is a group of several objects with a process. For Example: Educational System involves teacher, students (objects). Teacher teaches subject to students i.e., teaching (process). Similarly a computer system can have objects and process.
The following are the objects of computer System
a)User ( A person who uses the computer)
b)Hardware
c)Software
Hardware:	Hardware of a computer system can be referred as anything which we can touch and feel. Example : Keyboard and Mouse.
The hardware of a computer system can be classified as Input Devices(l/P)
Processing Devices (CPU) Output Devices(O/P)

KEYBOARD

INPUT

ALU: It performs the Arithmetic and Logical Operations such as
+,-,*,/	(Arithmetic Operators) &&, || ( Logical Operators)
CU: Every Operation such as storing , computing and retrieving the data should be governed by the control unit.

MU: The Memory unit is used for storing the data. The Memory unit is classified into two types.
They are	1) Primary Memory
2) Secondary Memory
Primary memory: The following are the types of memoruies which are treated as primary ROM: It represents Read Only Memory that stores data and instructions even when the computer is turned off. The Contents in the ROM can’t be modified once if they are written . It is used to store the BIOS information.
RAM: It represents Random Access Memory that stores data and instructions when the computer is turned on. The contents in the RAM can be modified any no. of times by instructions. It is used to store the programs under execution.
Cache memory: It is used to store the data and instructions referred by processor.
Secondary Memory: The following are the different kinds of memories
Magnetic Storage: The Magnetic Storage devices store information that can be read, erased and rewritten a number of times.
Example: Floppy Disks, Hard Disks, Magnetic Tapes
Optical Storage: The optical storage devices that use laser beams to read and write stored data. Example: CD(Compact Disk),DVD(Digital Versatile Disk)

COMPUTER SOFTWARE
Software of a computer system can be referred as anything which we can feel and see. Example: Windows, icons
Computer software is divided in to two broad categories: system software and application software .System software manages the computer resources .It provides the interface between the hardware and the users. Application software, on the other hand is directly responsible for helping users solve their problems.

System Software
System software consists of programs that manage the hardware resources of a computer and perform required information processing tasks. These programs are divided into three classes: the operating system, system support, and system development.

The operating system provides services such as a user interface, file and database access, and interfaces to communication systems such as Internet protocols. The primary purpose of this software is to keep the system operating in an efficient manner while allowing the users access to the system.
System support software provides system utilities and other operating services. Examples of system utilities are sort programs and disk format programs. Operating services consists of programs that provide performance statistics for the operational staff and security monitors to protect the system and data.
The last system software category, system development software, includes the language translators that convert programs into machine language for execution ,debugging tools to ensure that the programs are error free and computer —assisted software engineering(CASE) systems.

Application software
Application software is broken in to two classes: general-purpose software and application — specific software. General purpose software is purchased from a software developer and can be used for more than one application. Examples of general purpose software include word processors, database management systems ,and computer aided design systems. They are labeled general purpose because they can solve a variety of user computing problems.
Application —specific software can be used only for its intended purpose.
A general ledger system used by accountants and a material requirements planning system used by a manufacturing organization are examples of application-specific software. They can be used only for the task for which they were designed they cannot be used for other generalized tasks.
The relationship between system and application software is shown below. In this figure, each circle represents an interface point .The inner core is hard ware. The user is represented by the out layer. To work with the system, the typical user uses some form of application software. The application software in turn interacts with the operating system, which is a part of the system software layer. The system software provides the direct interaction with the hard ware. The opening at the bottom of the figure is the path followed by the user who interacts directly with the operating system when necessary.


COMPUTING ENVIRONMENTS
The word ‘compute’ is used to refer to the process of converting information to data. The advent of several new kinds of computers created a need to have different computing environments.
The following are the different kinds of computing environments available
1.Personal Computing Environment
2.Time Sharing Environment
3.Client/Server Environment
4.Distributed Computing Environment
Personal Computing Environment
In 1971, Marcian E. Hoff, working for INTEL combined the basic elements of the central processing unit into the microprocessor. If we are using a personal computer then all the computer hardware components are tied together. This kind of computing is used to satisfy the needs of a single user, who uses the computer for the personal tasks.
Ex: Personal Computer

Time-Sharing Environment
The concept of time sharing computing is to share the processing of the computer basing on the criteria time. In this environment all the computing must be done by the central computer.

The complete processing is done by the central computer. The computer which ask for processing are only dumb terminals.


Client/Server Environment
A Client/Server Computing involves the processing between two machines. A client Machine is the one which requests processing. Server Machine is the one which offers the processing. Hence the client is Capable enough to do processing. A portion of processing is done by client and the core(important) processing is done by Server.

Distributed Computing
A distributed computing environment provides a seamless integration of computing functions between different servers and clients. A client not just a requestor for processing the information from the server. The client also has the capability to process information. All the machines Clients/Servers share the processing task.

COMPUTER LANGUAGES
To write a program (tells what to do) for a computer, we must use a computer language. Over the years computer languages have evolved from machine languages to natural languages. The following is the summary of computer languages
1940’s	Machine Languages
1950’s	Symbolic Languages
1960’s	High Level Languages
Machine Language
In the earliest days of computers, the only programming languages available were machine languages. Each computer has its own machine language which is made of streams of 0’s and 1’s. The instructions in machine language must be in streams of 0’s and 1’s. This is also referred as binary digits. These are so named as the machine can directly understood the programs
Advantages:
1)High speed execution
2)The computer can understood instructions immediately
3)No translation is needed. Disadvantages:
1)Machine dependent
2)Programming is very difficult
3)Difficult to understand
4)Difficult to write bug free programs
5)Difficult to isolate an error

Symbolic Languages (or) Assembly Language
In the early 1950’s Admiral Grace Hopper, a mathematician and naval officer, developed the concept of a special computer program that would convert programs into machine language. These early programming languages simply mirrored the machine languages using symbols or mnemonics to represent the various language instructions. These languages were known as symbolic languages. Because a computer does not understand symbolic language it must be translated into the machine language. A special program called an Assembler translates symbolic code into the machine language. Hence they are called as Assembly language.
Advantages:
1)Easy to understand and use
2)Easy to modify and isolate error
3)High efficiency
4)More control on hardware Disadvantages:
1)Machine Dependent Language
2)Requires translator
3)Difficult to learn and write programs
4)Slow development time
5)Less efficient Example:
""",
  ),
  CourseData(
    name: 'Introduction to Web Development',
    description: 'Learn the basic of web development',
    imageUrl:
        "https://images.pexels.com/photos/251225/pexels-photo-251225.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    courseContent: """
Web technologies related to the interface between web servers and their clients. This information includes markup languages, programming interfaces and languages, and standards for document identification and display. In general web technology incorporates tools and techniques for web development.

Web Development is a broad term for the work involved in developing a web site for World Wide Web. This can include web design, web content development, client liaison, client-side7sewer-side scripting, web server and network security configuration, and e- commerce development. However, among web professionals, "web development" usually refers to the main non-design aspects of building web sites: writing markup and coding. Web development can range from developing the simplest static single page of plain text to the most complex web-based internet applications, electronic businesses, or social network services.

Web design is a broad term used to encompass the way that content (usually hypertext or hypermedia) is delivered to an end-user through the World Wide Web, using a web browser or other web-enabled software is displayed. The intent of web design is to create a website—a collection of online content including documents and applications that reside on a web servers. A website may include text, images, sounds and other content, and may be interactive.

For the typical web sites, the basic aspects of design are:

-The content. the substance, and information on the site should be relevant to the site and should target the area of the public that the website is concerned with.

-The usability. the site should be user-friendly, with the interface and navigation simple and reliable.

-The appearance. the graphics and text should include a single style that flows throughout, to show consistency. The style should be professional, appealing and relevant.

-The structure. of the web site as a whole.

Internet and its Evolution:


Internet is a short form of the technical term internetwork, the result of interconnecting computer networks with special gateways or routers. The Internet is also often referred to as the Net. The Internet is a massive network of networks, a networking infrastructure. It connects millions of computers together globally, forming a network in which any computer can communicate with any other computer as long as they are both connected to the Internet. Information that travels over the Internet does so via a variety of languages known as protocols. The Internet is loosely connected compared with the randomized graph.

The Internet is a globally distributed network comprising many voluntarily interconnected autonomous networks. It operates without a central governing body. However, to maintain interoperability, all technical and policy aspects of the underlying core infrastructure and the principal name spaces are administered by the Internet Corporation for Assigned Names and Numbers (ICANN).

The history of the Internet starts in the 1950s and 1960s with the development of computers. This began with point-to-point communication between mainframe computers and terminals, expanded to point-to- point connections between computers and then early research into packet switching.

Since the mid-1990s the Internet has had a drastic impact on culture and commerce, including the rise of near instant communication by electronic mail, instant messaging, Voice over Internet Protocol (VoIP) "phone calls", two-way interactive video calls, and the World Wide Web with its discussion forums, blogs, social networking, and online shopping sites.

World Wide Web:
WWW is a system of interlinked hypertext documents accessed via the Internet. The World Wide Web, or simply Web, is a way of accessing information over the medium of the Internet. It is an information-sharing model that is built on top of the Internet. The Web uses the HTTP protocol, only one of the languages spoken over the Internet, to transmit data. Web services, which use HTTP to allow applications to communicate in order to exchange business logic, use the Web to share information. The Web also utilizes browsers, such as Internet Explorer or Firefox, to access Web documents called Web pages that are linked to each other via hyperlinks. Web documents also contain graphics, sounds, text and video.

The Web is one of the services that runs on the Internet. It is a collection of textual documents and other resources, linked by hyperlinks and URLs, transmitted by web browsers and web servers. The Web is just one of the ways that information can be disseminated over the Internet, so the Web is just a portion of the Internet. In short, the Web can be thought of as an application "running" on the Internet

What is Hypertext?
Hypertext provides the links between different documents and different document types. In a hypertext document, links from one place in the document to another are included with the text. By selecting a link, you are able to jump immediately to another part of the document or even to a different document. In the WWW, links can go not only from one document to another, but from one computer to another


World Wide Consortium:
The World Wide Web Consortium   (W3C) is the main   international standards organization for the World Wide Web. W3C was created to ensure compatibility and agreement among industry members in the adoption of new standards. Prior to its creation, incompatible versions of HTML were offered by different vendors, increasing the potential for inconsistency between web pages. The consortium was created to get all those vendors to agree on a set of core principles and components which would be supported by everyone.

Web Page:
A web page is a document or information resource that is suitable for the World Wide Web and can be accessed through a web browser and displayed on a monitor or mobile device. This information is usually in HTML or XHTML format, and may provide navigation to other web pages via hypertext links. Web pages frequently subsume other resources such as style sheets, scripts and images into their final presentation.

Web pages may be retrieved from a local computer or from a remote web server. The web server may restrict access only to a private network, e.g. a corporate intranet, or it may publish pages on the World Wide Web. Web pages are requested and served from web servers using Hypertext Transfer Protocol (HTTP).

Web pages may consist of files of static text and other content stored within the web server's file system (static web pages), or may be constructed by server-side software when they are requested (dynamic web pages). Client-side scripting can make web pages more responsive to user input once on the client browser.

Web Site:
A website or simply site, is a collection of related web pages containing images, videos or other digital assets. A website is hosted on at least one web server, accessible via a network such as the Internet or a private local area network through an Internet address known as a Uniform Resource Locator. All publicly accessible websites collectively constitute the World Wide Web. Web sites can be static or dynamic.

Static Website:
A static website is one that has web pages stored on the server in the format that is sent to a client web browser. It is primarily coded in Hypertext Markup Language, HTML.

Simple forms or marketing examples of websites, such as classic website, a five-page website or a brochure website are often static websites, because they present pre-defined, static information to the user. This may include information about a company and its products and services via text, photos, animations, audio/video and interactive menus and navigation.

This type of website usually displays the same information to all visitors. Similar to handing out a printed brochure to customers or clients, a static website will generally provide consistent, standard information for an extended period of time. Although the website owner may make updates periodically, it is a manual process to edit the text, photos and other content and may require basic website design skills and software.

In summary, visitors are not able to control what information they receive via a static website, and must instead settle for whatever content the website owner has decided to offer at that time.

Dynamic Website:
A dynamic website is one that changes or customizes itself frequently and automatically, based on certain criteria.

Dynamic websites can have two types of dynamic activity: Code and Content. Dynamic code is invisible or behind the scenes and dynamic content is visible or fully displayed.

The first type is a web page with dynamic code. The code is constructed dynamically on the fly using active programming language instead of plain, static HTML.

The second type is a website with dynamic content displayed in plain view. Variable content is displayed dynamically on the fly based on certain criteria, usually by retrieving content stored in a database

Domain Names, DNS, and URLs:
IP addresses are not convenient for users to remember easily. So an IP address can be represented by a natural language convention called a domain name

Domain name system (DNS) translates domain names into IP addresses. DNS is the “phone book” for the Internet, it maps between host names and IP addresses.

A uniform resource locator (URL), which is the address used by a Web browser to identify the location of content on the Web, also uses a domain name as part of the URL.

Syntax: scheme: scheme-depend-part. Example: In http://www.example.com/, the scheme is http.


HTTP:
HTTP is based on the request-response communication model: o	Client sends a request
Server sends a response
	HTTP is a stateless protocol: where the protocol does not require the server to remember anything about the client between requests.
	Normally implemented over a TCP connection (80 is standard port number for HTTP)

	The following is the typical browser-server interaction using HTTP:
1.User enters Web address in browser
2.Browser uses DNS to locate IP address
3.Browser opens TCP connection to server
4.Browser sends HTTP request over connection
5.Server sends HTTP response to browser over connection
6.Browser displays body of response in the client area of the browser window

Client/Server Computing:

 A model of computing in which powerful personal computers are connected in a network together with one or more servers

	Client is a powerful personal computer that is part of a network; service requester

 Server is a networked computer dedicated to common functions that the client computers on the network need; service provider

 Web is based on client/server technology. Web servers are included as part of a larger package of internet and intranet related programs for serving e-mail, downloading requests for FTP files and building and publishing web pages. Typically the e-commerce customer is the client and the business is the server. In the client/ server model single machine can be both client and the server The client/ server model utilises a database server in which RDBMS user queries can be answered directly by the server.


architecture reduces network traffic by providing a query response to the user rather than transferring total files. The client/ server model improves multi-user updating through a graphical user interface (GUI) front end to the shared database. In client/ server architectures client and server typically communicate through statements made in structured query language (SQL).


Web Clients:

It typically refers to the Web browser in the user's machine. It is a software application for retrieving, presenting, and traversing information resources on the web server. It is used to create a HTTP request message and for processing the HTTP response message.

User agent: Any web client is designed to directly support user access to web servers is known as user agent. Web browsers can run on desktop or laptop computers. Some of the browsers are: Internet Explorer, Mozilla, FireFox, Chrome, Safari, Opera, Netscape Navigator.

Web Browsers:

Browsers are software programs that allow you to search and view the many different kinds of information that's available on the World Wide Web. The information could be web sites, video or audio information.



Status Bar: You will find the status bar at the very bottom of your browser window. It basically tells you what you are doing at the moment. Mainly, it shows you load speed and the URL address of whatever your mouse is hovering over.

Title Bar: You will find this bar at the absolute top of your browser and in will be the colour blue for the major browsers. The purpose of the Title bar is to display the title of the web page that you are currently viewing.

Menu Bar: The menu bar contains a set of dropdown menus

Navigational Tool: A bar contains standard push button controls that allow the user to return to a previously viewed page, to reverse and refresh the page, to display the home page and to print the page etc.

Toolbar Icons: You will find the Toolbar directly under the Title Bar. The Toolbar is where you will find the back button, home button and the refresh button etc.

Client Area: It is a display window which is the space in which you view the website.

Scroll Bars: The Scroll bars, usually located to the right of the Display Window, allows you to ”scroll" (move down or up the web page) so you can view information that is below or above what is currently in the Display Window.

Web Servers:

Basic functionality:
	It receives HTTP request via TCP
	It maps Host header to specific virtual host (one of many host names sharing an IP address)
	It maps Request-URI to specific resource associated with the virtual host o	File: Return file in HTTP response
	Program: Run program and return output in HTTP response


	It maps type of resource to appropriate MIME type and use to set Content-Type header in HTTP response
	It Logs information about the request and response
	All e-commerce site require basic Web server software to answer requests from customers like ;
	Apache
•Leading Web server software (47% of market)
•Works with UNIX, Linux , Windows OSs
oMicrosoft’s Internet Information Server (IIS)
•Second major Web server software (25% of market)
•Windows-based
    """,
  )
];
