(function ($, Drupal, drupalSettings) {
  'use strict';
  $(document).ready(function () {

    if ($('#decision-tree').length > 0) {
      const img_path = "/themes/custom/secgov/images/dt_images/";

      let dt = new Date();
      let hTime = dt.getHours() + dt.getMinutes() + dt.getSeconds();
      const file = "/files/oasb-wizard-tool.json" + '?version=' + hTime;

      document.querySelector('body').classList.add("has-dt");

      let scrollToMediaQuery = window.matchMedia('(max-device-width: 767px)');
      let scrollToOffset = 40;
      setMinHeight();

      function readJsonFile(file, callback) {
        let rawFile = new XMLHttpRequest();
        rawFile.overrideMimeType("application/json");
        rawFile.open("GET", file, true);
        rawFile.onreadystatechange = function () {
          if (rawFile.readyState === 4 && rawFile.status == "200") {
            callback(rawFile.responseText);
          }
        }
        rawFile.send(null);
      }

      readJsonFile(file, function (text) {

        const data = JSON.parse(text);// get Json data

        const rules = data.results;

        const type_question = data.slides.filter(function (slide) {
          return slide.page_type == "question";
        });

        let current_page = '';

        // Add 1 for result page
        const maxItems = type_question.length + 1;

        let start = 1;
        document.location.hash = start;

        let userResponse = {} // variable to store results
        let userRecord = [];

        window.localStorage.setItem('rules', JSON.stringify(rules));

        // Display questionaire
        getAQuestion(start, 0);
        choiceClicked();

        function choiceClicked() {
          let qid = $('.question').attr('data-question-id'); // get current question id
          let results = [];
          $('.next_id').on('click', function () {
            let nid = $(this).attr('data-next-id');
            let cid = $(this).attr('data-choice-id');
            let response = '';

            // userResponse.set(qid, cid); // save user response
            userResponse[qid] = cid;
            response = getRuleResponse(qid, cid);

            // userRecord saves the results base of user response.
            userRecord[qid] = response;
            getAQuestion(nid, 0); // display next slide/question


            // Compute final results before page load
            if (data.slides[qid].page_type === 'results') {
              results = computeResults(userRecord);
              window.localStorage.setItem('results', JSON.stringify(results));
              displayResults(results);
            }

            choiceClicked(); // reload and attach current function.
            scrollToElement();
          });

          $('.back-btn').on('click', function () {
            window.history.back();
          });
        }

        function verify(val) {
          return (val !== undefined) ? val : '';
        }

        // Getting a question and creating its HTML.
        function getAQuestion(id, cid) {
          current_page = id;
          let html, question, pre_text, moreInfo, moreInfo2, choices, post_text, page_type, pid;
          $(data.slides).each(function () {
            if (this.id == id) {
              question = verify(this.question);
              pre_text = verify(this.pre_text);
              moreInfo = verify(this.more_info);
              moreInfo2 = verify(this.more_info_2);
              choices = verify(this.choices);
              post_text = verify(this.post_text);
              page_type = verify(this.page_type);
              pid = verify(this.pid);
            }
          });

          html = '<div class="question-area clearfix">';
          html += pre_text ? '<div class="pre_text content-textarea">' + pre_text + '</div>' : '';
          html += question ? '<div class="question" data-question-id="' + id + '">' + question + '</div>' : '';
          html += moreInfo ? '<div class="moreInfo content-textarea">' + moreInfo + '</div>' : '';
          html += moreInfo2 ? '<div class="moreInfo2 content-textarea">' + moreInfo2 + '</div>' : '';
          html += post_text ? '<div class="post_text content-textarea">' + post_text + '</div>' : '';
          html += getChoices(choices, cid) && page_type == 'question' ? '<div class="all-choices" data-all-choices-id="' + id + '">' + getChoices(choices, cid) + '</div>' : '';
          html += '</div>';
          html += id != start ? '<div class="utility-buttons"><button class="back-btn">Back</button>' : '';
          html += page_type == 'resources' ? '<button class="continue-btn next_id" onclick="window.location.href=\'#' + choices[0].next_id + '\'" data-next-id="' + choices[0].next_id + '" data-choice-id="' + choices[0].cid + '"> Continue' + '</button>' : '</div>';

          $('#decision-tree').removeClass().addClass('dt-' + page_type).html(html);

          // Insert progress bar and update
          if ((page_type == 'question') || (page_type == 'results')) { // Increase progress for question and result page only
            $('.question').before('<div id="progress-container" class="progress-container"><div id="progress-bar" class="progress-bar"><span class="sr-only">Progress: </span><span class="progress-percent">0%</span></div></div>');
            progressBar(pid, maxItems); // move progress bar
          }
        }

        window.onhashchange = function () {
          let hash = parseInt(location.hash.replace(/^#/, ''));
          let cid = userResponse[hash];
          displayContent(hash, cid);
        };

        function displayContent(id, cid) {
          getAQuestion(id, cid);
          // Display results page when user is viewing methodolgy
          if (id == 11) {
            let results = JSON.parse(window.localStorage.getItem('results'));
            displayResults(results);
          }
          choiceClicked();
          scrollToElement();
        }

        // Getting choices and wrapping them within a DIV
        function getChoices(choices, optional_sel_cid) {
          let choicesHtml = '';
          $(choices).each(function () {
            choicesHtml += getChoice(this, optional_sel_cid);
          })
          return choicesHtml;
        }

        // Creating HTML for each choices
        function getChoice(cid, sel_cid) {
          let choiceHtml, id, text, img, next_id, link, selected;
          id = cid.cid;
          text = verify(cid.text);
          img = verify(cid.img);
          next_id = verify(cid.next_id);
          link = verify(cid.link);
          sel_cid = verify(sel_cid);
          selected = sel_cid == id ? ' selected' : '';

          // Check if image key is not empty
          if(img) {
            img = img.includes('files') ? img : img_path + img; // use theme image path if no path is provided
          }

          if (link) {
            choiceHtml = '<a href="' + link + '" class="next_id dt-img-btn' + selected + '" data-next-id="' + next_id + '" data-choice-id="' + id + '" target="_blank"">'
          } else {
            choiceHtml = '<a href="#' + next_id + '" class="next_id dt-img-btn' + selected + '" data-next-id="' + next_id + '" data-choice-id="' + id + '">'
          }

          choiceHtml += img ? '<div class="img"><img src="' + img + '" alt=""></div>' : '';
          choiceHtml += text ? '<div class="text">' + text + '</div>' : '';
          choiceHtml += '</a>'
          return choiceHtml;
        }

        // Progress bar
        function progressBar(pid, maxItems) {
          let width = pid / maxItems * 100;
          let progress = document.getElementById('progress-bar');
          let progressPercent = document.querySelector('.progress-percent');
          if (width <= 100) {
            let progressWidth = width;
            progress.style.width = progressWidth + '%';
            progressPercent.innerHTML = pid + ' of ' + maxItems;
          }
        }

        // Compute decision results
        function computeResults(userRecord) {
          let rule = JSON.parse(window.localStorage.getItem('rules'));
          let toRemove = [];
          let notRelevant = {};

          $(userRecord).each(function () {
            if (Array.isArray(this)) {
              toRemove.push(this)
            }
          });

          // Make array easier to interpret
          toRemove = [].concat.apply([], toRemove);

          // Find the rules that should be moved to non-relavant
          for (let i = 0; i < toRemove.length; i++) {
            if (rule.hasOwnProperty(toRemove[i])) {
              notRelevant[toRemove[i]] = rule[toRemove[i]];
              delete rule[toRemove[i]];
            }
          }
          return [rule, notRelevant];
        }

        // Get rules to remove based on question/choice id
        function getRuleResponse(qid, cid) {
          let value;
          $(data.slides).each(function () {
            if (this.id == qid) {
              $(this.choices).each(function () {
                if (this.cid == cid) {
                  value = verify(this.result_value);
                }
              });
            }
          });
          return value;
        }

        // Display the results page
        function displayResults(results) {
          let relevant = results[0], notRelevant = results[1];
          let relevanthtml, html, rules, img, title, link;

          // Create html for relevant results
          relevanthtml = '<div class=relevant-results-row>';
          for (let [key, value] of Object.entries(relevant)) {
            img = value.img;
            title = value.title;
            link = value.link;
            text = value.more_info;

            // Check if image key is not empty
            if (img) {
              img = img.includes('files') ? img : img_path + img; // use theme image path if no path is provided
            }

            relevanthtml += link ? '<a class=" dt-img-btn" href="' + link + '" target="_blank">' : '';
            relevanthtml += img ? '<div class="img"><img src="' + img + '" alt=""></div>' : '';
            relevanthtml += title ? '<div class="title">' + title + '</div>' : '';
            relevanthtml += '</a>';
          }
          relevanthtml += '</div>';
          $('.moreInfo').after(relevanthtml); // Apply relevant results container

          // Create html for other results
          html = '<div class="other-results-row">';

          // Force to follow sorted keys.
          let noneRelevant = notRelevant, keys = Object.keys(noneRelevant), i, len = keys.length;
          keys.sort();
          for (i = 0; i < len; i++) {
            let value = noneRelevant[keys[i]];
            title = value.title;
            link = value.link;
            text = value.more_info;
            img = value.img;

            // Check if image key is not empty
            if (img) {
              img = img.includes('files') ? img : img_path + img; // use theme image path if no path is provided
            }
            html += link ? '<a class=" dt-img-btn" href="' + link + '" target="_blank">' : '';
            html += img ? '<div class="img"><img src="' + img + '" alt=""></div>' : '';
            html += title ? '<div class="title">' + title + '</div>' : '';
            html += '</a>';
          }
          html += '</div>';
          $('.moreInfo2').after(html);

        }


      }); //end readJsonfile()

      function findPosition(obj) {
        let curtop = 0;
        if (obj.offsetParent) {
          do {
            curtop += obj.offsetTop;
          } while (obj = obj.offsetParent);
          return [curtop];
        }
      }

      function setMinHeight() {
        const wizardContainer = document.getElementById("decision-tree");
        if (scrollToMediaQuery.matches) {
          let footerHeight = document.querySelector('.page-footer').offsetHeight;
          let offset = footerHeight - scrollToOffset;
          wizardContainer.style.minHeight = "calc(100vh - " + offset + "px)";
        } else {
          wizardContainer.style.minHeight = 'auto';
        }
      }

      function scrollToElement() {
        // scroll top of content
        if (scrollToMediaQuery.matches) {
          //Prevent automatic page location restoration
          if (history.scrollRestoration) {
            history.scrollRestoration = 'manual';
          }
          const scrollToItem = document.querySelector(".article-title");
          window.scroll({
            top: findPosition(scrollToItem) - scrollToOffset,
            left: 0,
            behavior: 'smooth'
          });
        } else {
          if (history.scrollRestoration) {
            history.scrollRestoration = 'auto';
          }
        }
      }

      $(window).resize(function () {
        setMinHeight();
      });

    }// end decision outer if
  });
})(jQuery, Drupal, drupalSettings);
