(function () {

    var chat = {
      messageToSend: '',
        
      init: function () {
        this.cacheDOM();
        this.bindEvents();
        this.render();
        this.initListenWS();
      },
      cacheDOM: function () {
        this.$chatHistory = $('.chat-history');
        this.$button = $('button');
        this.$textarea = $('#message-to-send');
        this.$chatHistoryList = this.$chatHistory.find('ul');
      },
      bindEvents: function () {
        this.$button.on('click', this.addMessage.bind(this));
        this.$textarea.on('keyup', this.addMessageEnter.bind(this));
      },
      render: function () {
        this.scrollToBottom();
        if (this.messageToSend.trim() !== '') {
          var template = Handlebars.compile($("#message-template").html());
          var context = {
            messageOutput: this.messageToSend,
            time: this.getCurrentTime() };  
  
          this.$chatHistoryList.append(template(context));
          this.scrollToBottom();
          this.$textarea.val('');
        }  
      },
      send: function() {
        // Construct object containing the data the server needs.
        var data = {
            username: "customer",
            message: this.messageToSend,
            timestamp: new Date().getTime()
        };
        
        // Send the msg object as a JSON-formatted string.
        this.publishSocket.send(JSON.stringify(data)); 
      },
      initListenWS: function () {

        this.publishSocket = new WebSocket("ws://localhost:3880/ws/customer/receive");
        this.listenSocket = new WebSocket("ws://localhost:3880/ws/customer/publish");

        this.listenSocket.onmessage = function (event) {
            // When receiving a message append a div child to #messages
            data = JSON.parse(event.data);
            var contextResponse = {
                response: data.message,
                time: this.getCurrentTime() 
            };

            var templateResponse = Handlebars.compile($("#message-response-template").html());
            this.$chatHistoryList.append(templateResponse(contextResponse));
            this.scrollToBottom();
            
        }.bind(this)
      
        this.listenSocket.onclose = function(event) {
            //this.messageToSend = "Disconnected from server.";
            //this.render();
            console.log("Disconnected from server.");
            //$("#messages").append("<div class='msg server'>Disconnected from server.</div>");
        }.bind(this)
      
        this.listenSocket.onopen = function(event) {
            //this.messageToSend = "Connected to server.";
            //this.render();
            console.log("Connected to server.");
            //$("#messages").append("<div class='msg server'>Connected to server.</div>")
        }.bind(this)  
      }, 
      addMessage: function () {
        this.messageToSend = this.$textarea.val();
        this.send();
        this.render();        
      },
      addMessageEnter: function (event) {
        // enter was pressed
        if (event.keyCode === 13) {
          this.addMessage();
        }
      },
      scrollToBottom: function () {
        this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
      },
      getCurrentTime: function () {
        return new Date().toLocaleTimeString().replace(/([\d]+:[\d]{2})(:[\d]{2})(.*)/, "$1$3");
      } };
    
    chat.init();
  
    // left panel search
    var searchFilter = {
      options: { valueNames: ['name'] },
      init: function () {
        var userList = new List('people-list', this.options);
        var noItems = $('<li id="no-items-found">No items found</li>');
  
        userList.on('updated', function (list) {
          if (list.matchingItems.length === 0) {
            $(list.list).append(noItems);
          } else {
            noItems.detach();
          }
        });
      } };  
  
    searchFilter.init();
  
  })();