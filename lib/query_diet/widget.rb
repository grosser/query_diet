module QueryDiet
  class Widget
    class << self

      def render(response)
        body = response.body
        if response.content_type == "text/html" && position = body.index('</body>')
          body.insert(position, css)
          body.insert(position, html)
        end
      end

      private

      def css
        <<-EOF
        <style type="text/css"><!--
          div#query_diet {
            position: absolute;
            top: 0;
            right: 0;
            background-color: black;
            color: white;
            z-index: 999;
            padding: 4px 6px;
            font: normal bold 12px/12px Arial, sans-serif;
            cursor: pointer;
          }
          div#query_diet.good {
            filter:alpha(opacity=30);
            -moz-opacity:0.3;
            -khtml-opacity: 0.3;
            opacity: 0.3;
          }
          div#query_diet.bad {
            background-color: red;
            font-size: 16px;
            line-height: 16px;
          }
        --></style>
        EOF
      end

      def html
        <<-EOF
        <div id="query_diet" class="#{QueryDiet::Logger.bad? ? 'bad' : 'good' }" onclick="this.parentNode.removeChild(this);">
          #{QueryDiet::Logger.count} / #{QueryDiet::Logger.time}ms
        </div>
        EOF
      end

    end
  end
end
