import parse from 'html-react-parser';

import twigTemplate from './space.twig';
import md from './space.md';
import data from '../../00-config/config.design-tokens.yml';

const settings = {
  title: 'Global/Spacing',
  parameters: {
    docs: {
      description: {
        component: md,
      },
    },
  },
  argTypes: {
    gesso: {
      table: {
        disable: true,
      },
    },
  },
};

const Spacing = args =>
  parse(
    twigTemplate({
      ...args,
    })
  );

Spacing.args = { ...data };

export default settings;
export { Spacing };
