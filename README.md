### The point of this document

---

- documentation

  - get started
  - public interface: this is a lot of work and should really be made available through RDocs

- Portfolio aspects

  - the original idea
    Render text into textures for usage in video games that do not necessarily need on-the-fly font texture generation. Just rendering a quad or two triangles is still the cheapest way of rendering text because it requires no extra computation and uses graphics hardware where it is good at.
    Drawing triangles and textures.

  - How this works technically and what is the driving good idea behind the approach?

  - inspiration

  - considerations

    - types of supported characters
      The supported characters are based on two things:

      - What the ASCI standard considers printable characters
        The ASCII standard defined the character code range (32..126) to be 'printable characters', which result in a total of 126−32+1=95 printable characters.

      - What I though would be interesting to have available and intuitively understandable without enforcing weird rules.
        Mainly this mean to ignore most of the control characters and only support basic text flow with the characters:

        - Newline: Advance the text cursor vertically onto the next line
        - Space    : While not a control character, it behaves like one.

        These two characters are very clear in what they do and enable the user to design textual images with the supported character designs and empty cells for both the horizontal and vertical axis.
        


      The types of characters are divided into two 'groups'

      - plottable/design: Printable characters that have a design associated with them. This excludes the non-printing characters.
      - control: Non-printable characters that that do not have a design associated with them but affect the flow of the text.
        Currently on the newline character is supported as control character.
        In the future, the space will probably be added to this category since it does not actually have a design (it is empty) and is technically only used to separate characters in a text.

    - time management, initial scope, scope creap an unforeseen problems

    - why a gem

    - image type

    - performance

    - image size

      While chunky_png and the PNG specifications can handle extremely high image dimensions in both the horizontal and vertical direction, I wanted to keep the images at a reasonable size that reflects the intentional use, which is video games or other rendering centric applications.

      Initial tests showed that a naive approach to generating a 4K resolution image took a few seconds on a mid-level consumer laptop:
      This has many reasons off course, some of which are:

      - ruby is interpreted
      - the chunky_png
      - data locality and algorithms used
      - OOP
      - size of the image
      - etc etc

      which made it clear that the naive approach could potentially be a problem, because this application/Gem was supposed to be used for a simple website application, and in a stateless HTTP/S request-response, long request-response round-trips are something to be heavily avoided. However, starting with an optimization is usually bad, and a fully working application can always be optimized later.

      The consumer 4K maximum image resolution was chosen so that a games/application that use these images could generate images that span the full size of these 4K display. Coincidentally, the resolution of 3840x2160 nicely divides into the character glyph size 5x9.
      This means that a text block with (2160/9) = 240 lines and (3840/5) = 768 columns fits exactly into that maximum supported image resolution and was a happy coincidence.

    - public interface

      - powerful yet elegant interface
      - the shorter and expressive the interface method invocations the better
      - clear and minimal amount of argument

    - errors or return values
      In order to enforce the internal requirements and limitations, the options were mostly between:

      - raising exceptions
      - return values
      - mixture of exceptions and return values

      After considering my options and initially wanting to stay away from exceptions I finally went with a fully exception driven approach.

      I come from C and loved the following ideas, because that is what I was accustomed to:

      - return codes and objects for all methods and then determine actions based on these return codes by checking API level constants
      - being able to print a  very specific error for every relevant action that failed in some way
      - the ability to ignore return values
      - I.e. I was not accustomed to exceptions and really wanted to avoid them for no specific reason

      I then came across a blog post that went through the advantages and disadvantages or both or mixed approaches and I finally decided to just use exceptions in order to disable the Gem user from ignoring the raised errors. While the current implementation goes overboard on the custom error types implemented, it does what it is supposed to do and forces the user to at least look at the error or catch it.

      I found this an interesting experiment to break loose from my assumptions and see to what sort of usability advantages and problems exceptions could lead.

    - performance

  - what went right

  - what went wrong

    - The exception based approach is very verbose and many classes have been implemented solely to make the error message clearer.
      While it makes the error message clearer in its intention to guide the user where exactly the error happened and how to fix the error by stating what the supported options are, the same could be achieved by using a single or at least a reduced amount Exception types.

      This implementation is subject to big change, but the reason I added so many Exception classes has many reasons:

      - Not knowing what sorts of invalid input I missed in the initial design. At that point I should have gone with a single or even a standard error type in order to avoid the over-complication and re-evaluate later when all/most of the invalid input would come to light.
      - Wanting clear separation of concerns between the different settings setter methods so that the user could account for all the invalid input for a specific setting by catching specific error classes. I though this would be good to enable a user to catch specific errors for a given setting type so that, for instance, when setting the text, the user could check for:
        - Invalid characters in the original text
        - Empty text either before or after the optional unsupported character replacement procedure
        - Invalid characters in the replacement text, which is supposed to be used as valid fall-back of invalid text
        - A text line that is too long because it requires more than the consumer 4K resolution width or the horizontal spacing makes it surpass that image resolution limit
        - A text that has too many lines and requires more vertical space than the limit 4K consumer resolution has or the vertical spacing makes it surpass that limit

      The problem is that, mostly the text setting, has too many errors types to raise. This was an unforeseen consequence of previous decisions, because originally the #pngfy and text setting were combined in a single method call in order to generate the final result.

      By separating the result generation from the text setting, these concerns were separated, but the minimalist interface came at the price of more complexity in terms of handling this in a single method call and communicating the reason for failures and possibly hints to fix the problem when this, now more complex system failed.

    - Currently there is no simple way determine wether a specific input is valid before using the interface, because I wanted to enforce the interface through exceptions first, and then at some point add the minimal amount of static functionality that can help a user to dynamically construct valid input and avoid exceptions altogether.

  - demo

  - what I learned

    - up front design
      - ... could not anticipate despite knowing that I could not anticipate, but still tried ...
    - up front design and TDD
    - evolving my workflow using:
      1. Implement a failing test (RED)
      2. Write just enough code to pass the test (GREEN)
      3. Re-factor/design the implementation **and** the tests (which I failed to do after a while)
         and documenting while doing so
      4. Rubocop implementation and tests. Sometimes it may be desirable to keep Rubocop complaints in a commit, because not every architectural issue should or can be tackled right away. Rubocop will not forget about a complaint, but a human will forget to re-enable
         Rubocop rules if the point is just to have a 'clean commit'.
      5. At this point make sure that all tests still pass and Rubocop has no complaints (ideally)
      6. Commit using a clear short commit message and elaborate in the commit message body in case more needs to be explained through that same commit message.
      7. Repeat at step `1` until all needed features are implemented
    - Tests
      - Testing specifics is not good, start with generals/public api and then narrow down as design solidifies (and even then)





### Observed Bugs

---

- When text contains invalid unicode character, the error message conveys that the text contains more than a single unsupported character through the error message ' and some_unsupported_character are ...' despite the fact that the unicode character should be considered a single unsupported character and not multiple ones. This seems like an implementation mistake during unsupported character extraction to provide the error message.



### What needs to be changed

---

- Re-design all test suites
- Render images faster, avoid unnecessary work and check on the chunky_png level what sort of optimizations can be made
- Simplify the current implementation
- Add static functionality that represent as much of the valid/supported ranges of input for each setting. This is probably hard to implement in a minimal manner since a few settings can fail for a variety of input.
  Something that is clearly a good idea is to provide an array/range of supported plottable character, control characters etc.
- While the code is fully documented using comments as Rubocop desired, it would be nice to have proper RDoc documenation. This will probably be done by the point the implementation solidified.
- Determine a 'build system' and bump the according SemVer version number accordingly when building, based on the actual changes made and adhering to the SemVer standard in terms of when patches are made, non-api-breaking changes are implemented and when the public api changes.
- An online demo using a simple HTTP and HTML interface
- Make sure that exceptions raised also work in situation where the user decides to catch the error, but fails to gracefully handle the error, i.e, when the error persists in the state of the implementation because no action was taken, and the procedures which should be enforced by the raised error are ingored.



### Ideas for the future of this gem

---

- The gem is tested in terms of the source code, i.e. the files contained in the `/lib`  folder, but ideally the gem should be:

  1. Tested in terms of the implementation files in the `/lib` folder
  2. Rubocop'ed without complaints
  3. Build locally through the Gemspec into a *.gem file
  4. Tested in terms of using the built *.gem file as it is intended by using bundler in a temporary project.
     There are many ad hoc approaches to using the *.gem file as local gem but none of the ones I found seem appropriate or are brittle in terms of their reproducibility.
  5. Publish the gem at this point because it is proven to work as implementation and as Gem.

  The test suite could maybe  be written in a manner that it tests **both** the raw source code and the Gem after building it.
  The reason this seems like a good approach to developing, testing and publishing gems is that between the writing the implementation and building the Gem, a single mistake like not actually adding all the `/lib` files required for the *.gem to work can break the actual unit that is used later, making    

  the tests irrelevant.

- Adding line-through formatting

- Adding border rendering

- Adding image margin/padding

- Adding result data points that make the character positions and the respective bounding boxes iterateable