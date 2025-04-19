// app/javascript/controllers/emoji_picker_controller.js
import { Controller } from "@hotwired/stimulus"
import EmojiPicker from '@emoji-picker/react';

export default class extends Controller {
  static targets = ["picker", "input"]

  connect() {
    this.picker = new EmojiPicker({
      target: this.pickerTarget,
      props: {
        onEmojiSelect: this.selectEmoji.bind(this)
      }
    });
  }

  toggle() {
    this.pickerTarget.classList.toggle('hidden')
  }

  selectEmoji(emoji) {
    const input = this.inputTarget
    const startPos = input.selectionStart
    const endPos = input.selectionEnd
    const emojiChar = emoji.native
    
    input.value = input.value.substring(0, startPos) + emojiChar + input.value.substring(endPos)
    input.focus()
    input.selectionStart = input.selectionEnd = startPos + emojiChar.length
    this.pickerTarget.classList.add('hidden')
  }
}