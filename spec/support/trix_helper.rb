module TrixHelper
  def fill_in_trix_editor(content)
    find("trix-editor") # Wait for editor to be present
    page.execute_script(<<~JS)
      (function() {
        const editor = document.querySelector('trix-editor');
        const input = editor.inputElement;
        const html = '<div>#{content.gsub("'", "\\\\'")}</div>';
        if (editor.editor) {
          editor.editor.loadHTML(html);
        }
        if (input) {
          input.value = html;
        }
      })();
    JS
  end

  def fill_in_trix_editor_within(selector, content)
    find("#{selector} trix-editor") # Wait for editor to be present
    page.execute_script(<<~JS)
      (function() {
        const editor = document.querySelector('#{selector} trix-editor');
        const input = editor.inputElement;
        const html = '<div>#{content.gsub("'", "\\\\'")}</div>';
        if (editor.editor) {
          editor.editor.loadHTML(html);
        }
        if (input) {
          input.value = html;
        }
      })();
    JS
  end
end

RSpec.configure do |config|
  config.include TrixHelper, type: :system
end
